//
//  DataTransferManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import Foundation
import NearbyInteraction
import MultipeerConnectivity

final class DataTransferManager: NSObject, ObservableObject {
    private let serviceType = "DiverBook"
    var peerID: MCPeerID!
    var session: MCSession!
    private var niSession: NISession?
    private var nearbyToken: NIDiscoveryToken?
    private var advertiserManager: AdvertiserManager?
    private var browserManager: BrowserManager?
    weak var viewModel: DiverSearchingViewModel?
    @Published var isBrowser: Bool = false
    
    private let minDistance: Float = 0.2
    private let maxDistance: Float = 0.3

    // TODO: - 내 실제 닉네임 전달해주도록 변경
    @Published var myNickname: String = "User\(Int.random(in: 1000...9999))"
    @Published var receivedNickname: String = ""

    init(nickname: String, viewModel: DiverSearchingViewModel) {
        self.myNickname = nickname
        self.viewModel = viewModel
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(
            peer: peerID,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        super.init()
        advertiserManager = AdvertiserManager(dataTransferManager: self)
        browserManager = BrowserManager(dataTransferManager: self)
        session.delegate = self
        
        setupNISession()
    }

    func startSession() {
        advertiserManager?.start()
        print("🔊 광고 시작됨")
        browserManager?.start()
        print("🔍 브라우징 시작됨")
    }
    
    func stopSession() {
        advertiserManager?.endSession()
        browserManager?.endSession()
        niSession?.invalidate()
        session.disconnect()
    }
    
    private func setupNISession() {
        print("setupNISession")
        niSession = NISession()
        niSession?.delegate = self
    }
    
    private func runNISession(with token: NIDiscoveryToken) {
        print("runNISession")
        let config = NINearbyPeerConfiguration(peerToken: token)
        niSession?.run(config)
    }
    
    private func sendNicknameIfWithinRange(distance: Float) {
        print("sendNicknameIfWithinRange")
        if distance >= minDistance && distance <= maxDistance {
            sendNickname()
            niSession?.invalidate()
        }
    }
    
    private func sendNickname() {
        print("sendNickname")
        guard !session.connectedPeers.isEmpty else { return }
        if let data = myNickname.data(using: .utf8) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
}

// MARK: - MCSessionDelegate
extension DataTransferManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .connected {
            if let token = niSession?.discoveryToken {
                if let data = try? NSKeyedArchiver.archivedData(
                    withRootObject: token,
                    requiringSecureCoding: true
                ) {
                    try? session.send(data, toPeers: [peerID], with: .reliable)
                }
                return
            }
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let object = try? NSKeyedUnarchiver.unarchivedObject(
            ofClass: NIDiscoveryToken.self,
            from: data
        ) {
            DispatchQueue.main.async {
                self.nearbyToken = object
                self.runNISession(with: object)
            }
            return
        }

        // 닉네임 수신 처리
        if let nickname = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.receivedNickname = nickname
                self.viewModel?.action(.successSearchingDiver(nickname: nickname))
                print("📥 받은 닉네임: \(nickname)")
            }
        }
    }

    func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) {}
    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}
    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}
}

// MARK: - NearbyInteraction Delegate
extension DataTransferManager: NISessionDelegate {
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let object = nearbyObjects.first, let distance = object.distance else { return }

        print("기기 간 거리: \(distance)m")

        sendNicknameIfWithinRange(distance: distance)
    }

    func sessionWasSuspended(_ session: NISession) {
        session.run(session.configuration!)
    }

    func session(_ session: NISession, didInvalidateWith error: Error) {
        print("❌ NI 세션 종료: \(error.localizedDescription)")
        niSession = nil
    }
}

//
//  DataTransferManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import Foundation
import MultipeerConnectivity
import NearbyInteraction

final class DataTransferManager: NSObject, ObservableObject {
    var peerID: MCPeerID
    var session: MCSession
    private let nickname: String
    private var niSession: NISession?
    private var nearbyToken: NIDiscoveryToken?
    private var advertiserManager: AdvertiserManager?
    private var browserManager: BrowserManager?
    private weak var viewModel: DiverSearchingViewModel?
    
    let serviceType = "DiverBook"
    private let minDistance: Float = 0.2
    private let maxDistance: Float = 0.3

    // TODO: - 내 실제 닉네임 전달해주도록 변경
    @Published var isBrowser: Bool = false
//    @Published var myNickname: String = "User\(Int.random(in: 1000...9999))"
    @Published var receivedNickname: String = ""

    init(nickname: String, viewModel: DiverSearchingViewModel) {
        self.nickname = nickname
        self.viewModel = viewModel
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(
            peer: peerID,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        super.init()
        self.session.delegate = self
        self.advertiserManager = AdvertiserManager(dataTransferManager: self)
        self.browserManager = BrowserManager(dataTransferManager: self)
        
        setupNISession()
    }

    func startSession() {
        stopSession()
        setupNISession()
        advertiserManager?.start()
        browserManager?.start()
        print("✅ Start advertising & browsing")
    }
    
    func stopSession() {
        advertiserManager?.stop()
        browserManager?.stop()
        niSession?.invalidate()
        session.disconnect()
    }
    
    private func setupNISession() {
        niSession = NISession()
        niSession?.delegate = self
        print("✅ setupNISession")
    }
    
    private func runNISession(with token: NIDiscoveryToken) {
        let config = NINearbyPeerConfiguration(peerToken: token)
        niSession?.run(config)
        print("✅ runNISession")
    }
    
    private func sendNicknameIfWithinRange(distance: Float) {
        guard distance >= minDistance && distance <= maxDistance else { return }
        sendNickname()
        niSession?.invalidate()
    }
    
    private func sendNickname() {
        guard !session.connectedPeers.isEmpty,
              let data = nickname.data(using: .utf8) else { return }
        try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        print("✅ sendNickname")
    }
}

// MARK: - MCSessionDelegate
extension DataTransferManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        guard state == .connected,
              let token = niSession?.discoveryToken else { return }
        if let data = try? NSKeyedArchiver.archivedData(
            withRootObject: token,
            requiringSecureCoding: true
        ) {
            try? session.send(data, toPeers: [peerID], with: .reliable)
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let token = try? NSKeyedUnarchiver.unarchivedObject(
            ofClass: NIDiscoveryToken.self,
            from: data
        ) {
            DispatchQueue.main.async {
                self.nearbyToken = token
                self.runNISession(with: token)
            }
            return
        }

        if let nickname = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.receivedNickname = nickname
                self.viewModel?.action(.successSearchingDiver(nickname: nickname))
                print("✅ 받은 닉네임: \(nickname)")
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
        guard let configuration = session.configuration else { return }
        session.run(configuration)
    }

    func session(_ session: NISession, didInvalidateWith error: Error) {
        print("❌ NI 세션 종료: \(error.localizedDescription)")
        niSession = nil
    }
}

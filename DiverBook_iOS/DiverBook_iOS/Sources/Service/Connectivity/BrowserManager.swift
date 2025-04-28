//
//  BrowserManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import MultipeerConnectivity

final class BrowserManager: NSObject, MCNearbyServiceBrowserDelegate {
    private let dataTransferManager: DataTransferManager?
    private var browser: MCNearbyServiceBrowser?
    private let myUUID = UUIDManager.shared.uuid

    init(dataTransferManager: DataTransferManager) {
        self.dataTransferManager = dataTransferManager
        super.init()
        browser = MCNearbyServiceBrowser(
            peer: dataTransferManager.peerID,
            serviceType: dataTransferManager.serviceType)
        browser?.delegate = self
    }

    func start() {
        browser?.stopBrowsingForPeers()
        browser?.startBrowsingForPeers()
        print("start browsing")
    }
    
    func stop() {
        browser?.stopBrowsingForPeers()
    }
    
    func browser(_ browser: MCNearbyServiceBrowser,
                 foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String: String]?
    ) {
        guard let peerUUID = info?["uuid"], myUUID < peerUUID else { return }
        browser.invitePeer(
            peerID,
            to: dataTransferManager?.session ?? MCSession(
                peer: MCPeerID(displayName: UIDevice.current.name)),
            withContext: nil,
            timeout: 10)
        print("invitePeer")
    }

    func browser(_: MCNearbyServiceBrowser, lostPeer _: MCPeerID) {}
}

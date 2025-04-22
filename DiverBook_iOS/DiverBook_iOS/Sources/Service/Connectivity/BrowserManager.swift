//
//  BrowserManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import MultipeerConnectivity

final class BrowserManager: NSObject, MCNearbyServiceBrowserDelegate {
    private let dataTransferManager: DataTransferManager
    private var browser: MCNearbyServiceBrowser?
    private let myUUID = UUIDManager.shared.uuid

    init(dataTransferManager: DataTransferManager) {
        self.dataTransferManager = dataTransferManager
        super.init()
        browser = MCNearbyServiceBrowser(peer: dataTransferManager.peerID, serviceType: "DiverBook")
        browser?.delegate = self
    }

    func start() {
        browser?.stopBrowsingForPeers()
        browser?.startBrowsingForPeers()
        print("start browsing")
    }
    
    func endSession() {
        browser?.stopBrowsingForPeers()
    }
    
    func browser(_: MCNearbyServiceBrowser,
                 foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String : String]?
    ) {
        guard let peerUUID = info?["uuid"] else { return }
        
        if myUUID < peerUUID {
            browser?.invitePeer(peerID, to: dataTransferManager.session, withContext: nil, timeout: 10)
            print("invitePeer")
        }
    }

    func browser(_: MCNearbyServiceBrowser, lostPeer _: MCPeerID) {}
}

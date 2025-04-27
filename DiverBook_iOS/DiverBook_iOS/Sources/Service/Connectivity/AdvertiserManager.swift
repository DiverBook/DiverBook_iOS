//
//  AdvertiserManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import MultipeerConnectivity

final class AdvertiserManager: NSObject, MCNearbyServiceAdvertiserDelegate {
    private let dataTransferManager: DataTransferManager?
    private var advertiser: MCNearbyServiceAdvertiser?

    init(dataTransferManager: DataTransferManager) {
        self.dataTransferManager = dataTransferManager
        super.init()
        advertiser = MCNearbyServiceAdvertiser(
            peer: dataTransferManager.peerID,
            discoveryInfo: ["uuid": UUIDManager.shared.uuid],
            serviceType: dataTransferManager.serviceType
        )
        advertiser?.delegate = self
    }

    func start() {
        advertiser?.stopAdvertisingPeer()
        advertiser?.startAdvertisingPeer()
        print("start advertising")
    }

    func stop() {
        advertiser?.stopAdvertisingPeer()
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        print("📩 초대 수신 : \(peerID.displayName)")
        invitationHandler(true, dataTransferManager?.session)
    }
}

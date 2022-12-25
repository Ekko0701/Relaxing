//
//  MPRemoteCommandCenterManager.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/23.
//

import Foundation
import MediaPlayer

class MPRemoteCommandCenterManager {
    static let shared = MPRemoteCommandCenterManager()
    
    func remoteCommandCenterSetting() {
        // Remote Control Event 받기 시작
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let center = MPRemoteCommandCenter.shared()
        
        // 제어 센터 재생버튼 누르면 발생할 이벤트 처리
        center.playCommand.addTarget { (commandEbent) -> MPRemoteCommandHandlerStatus in
            SoundManager.shared.playAndPauseAll()
            return MPRemoteCommandHandlerStatus.success
        }
        
        // 제어 센터 일시정지 버튼 누르면 발생할 이벤트 처리
        center.pauseCommand.addTarget { (commandEbent) -> MPRemoteCommandHandlerStatus in
            SoundManager.shared.playAndPauseAll()
            return MPRemoteCommandHandlerStatus.success
        }
    }
    
    func remoteCommandInfoCenterSetting() {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = "Relaxing"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Relaxing"
        if let albumCoverPage = UIImage(named: "AppIcon") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                return albumCoverPage
            })
        }
        
        center.nowPlayingInfo = nowPlayingInfo
    }
}

//
//  SoundManager.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import AVFoundation

/**
 오디오 재생 메니저 ( Singleton )
 */
final class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let shared = SoundManager()
    
    /**
     현재 재생중인 player 딕셔너리, key값은 title이다.
     */
    var audioPlayers: [String: AVAudioPlayer] = [:]
    
    private override init() {}
    
    /**
     재생 & 정지 메서드
     */
    func play(sound: Sound) {
        let title = sound.getTitle()
        let fileName = sound.getFileName()
        let fileExtension = sound.getFileExtension()
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let player = getAudioPlayer(title: title, for: url) else { return }

        if let playingPlayer = audioPlayers[title] {
            if playingPlayer.isPlaying {
                audioPlayers.removeValue(forKey: title)
                playingPlayer.stop()
            } else {
                player.volume = sound.getVolume()
                player.numberOfLoops = -1 // 무한 반복
                player.prepareToPlay()
                player.play()
            }
        } else {
            print("url audioPlayer에 없습니다.")
        }
    }
    
    /**
     Sound의 title과 url을 받아 player를 생성해 audioPlayers에 추가하고 반환한다.
     */
    private func getAudioPlayer(title: String, for url: URL) -> AVAudioPlayer? {
        /*
         [audioPlayer]에 해당 url을 key값으로 하는 player가 없는 경우
         url로 player를 생성해 [audioPlayer]에 추가한다.
         이때, 생성한 player를 반환한다.
         */
        guard let player = audioPlayers[title] else {
            // AVAudioPlayer 생성
            let player = try? AVAudioPlayer(contentsOf: url)
            // 생성한 player를 audioPlayers 딕셔너리에 추가
            audioPlayers[title] = player
            return player
        }
        /*
         url로 생성한 player가 [audioPlayer]에 존재하지만 playing 중이 아니면 player를 반환
         */
        guard player.isPlaying else { return player }
        
        /*
         [audioPlayer]에 url로 생성한 player가 존재하고 재생중인 경우
         player반환한다.
         */
        guard let duplicatePlayer = try? AVAudioPlayer(contentsOf: url) else { return nil }
        return duplicatePlayer
    }
    
    func changeVolume(player: AVAudioPlayer, size: Float) {
        player.setVolume(size, fadeDuration: 0)
    }
}

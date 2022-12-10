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
    
    var entirePlaying: Bool = false
    var isNothingPlaying: Bool = true
    
    private override init() {}
    
    /**
     개별 Player 재생 및 정지 메서드
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
                
                _ = audioPlayers.mapValues { player in
                    player.play()
                    entirePlaying = true
                }
            }
        } else {
            print("선택한 player를 재생목록에서 제거함.")
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
         전체 일시 정지 상태일때 player가 [audioPlayer]에 존재하는 경우 [audioPlayer]에서 제거한다.
         */
        if !(player.isPlaying) {
            audioPlayers.removeValue(forKey: title)
        }
        
        /*
         [audioPlayer]에 url로 생성한 player가 존재하고 재생중인 경우
         player반환한다.
         */
        guard let duplicatePlayer = try? AVAudioPlayer(contentsOf: url) else { return nil }
        return duplicatePlayer
    }
    
    /**
     Player의 Volumn 조절 메서드
     */
    func changeVolume(player: AVAudioPlayer, size: Float) {
        player.setVolume(size, fadeDuration: 0)
    }
    
    /**
     Control Bar View의 재생 컨트롤
     */
    func playAndPauseAll() {
        print("현재 재생 목록 : \(audioPlayers.keys)")
        if !(audioPlayers.isEmpty) { // audioPlayers(재생 목록)에 사운드가 존재할 때
            if entirePlaying == true { // 전체 재생 목록이 플레이 중이면
                _ = audioPlayers.mapValues { player in
                    player.pause() // 모든 플레이어 일시 정지
                    entirePlaying = false
                }
            } else { // 전체 재생 목록이 플레이 중이 아니라면 = 일시 정지 상태라면
                _ = audioPlayers.mapValues { player in
                    player.play() // 모든 플레이어 시작
                    entirePlaying = true
                }
            }
        }
    }
}

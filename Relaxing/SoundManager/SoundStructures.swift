//
//  SoundStructures.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

protocol Sound {
    func getTitle() -> String
    func getFileName() -> String
    func getFileExtension() -> String
    func getVolume() -> Float
    
    var isPlaying: Bool { get set }
    var soundTitle: String { get set }
}

extension Sound {
    func getVolume() -> Float { 1 }
    
}

struct BirdSound: Sound {
    var soundTitle = "BirdSound"
    
    func getTitle() -> String { "BirdSound" }
    func getFileName() -> String { "bird_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

struct HighWaySound: Sound {
    var soundTitle = "HighWaySound"
    
    func getTitle() -> String { "HighWaySound" }
    func getFileName() -> String { "highway_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

struct WaterSound: Sound {
    var soundTitle = "WaterSound"
    
    func getTitle() -> String { "WaterSound" }
    func getFileName() -> String { "water_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

//struct SoundData {
//    let title: String
//    let fileName: String
//    let filrExtension: String
//    let image: UIImage
//}

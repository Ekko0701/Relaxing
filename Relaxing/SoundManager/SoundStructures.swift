//
//  SoundStructures.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

/** Sound Protocol */
protocol Sound {
    func getTitle() -> String
    func getFileName() -> String
    func getFileExtension() -> String
    
    /** 태그 = MainView의 indexPath.item*/
    var tag: Int { get set }
    var soundTitle: String { get set }
    var volumeSize: Float { get set }
}

extension Sound {
    func getVolume() -> Float { 1 }
    
}

// MARK: - Sound Structs
struct BirdSound: Sound {
    var tag = 0
    var soundTitle = "BirdSound"
    
    func getTitle() -> String { "BirdSound" }
    func getFileName() -> String { "bird_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct HighWaySound: Sound {
    var tag = 1
    var soundTitle = "HighWaySound"
    
    func getTitle() -> String { "HighWaySound" }
    func getFileName() -> String { "highway_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct WaterSound: Sound {
    var tag = 2
    var soundTitle = "WaterSound"
    
    func getTitle() -> String { "WaterSound" }
    func getFileName() -> String { "water_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

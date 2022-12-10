//
//  SoundStructures.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation

protocol Sound {
    func getTitle() -> String
    func getFileName() -> String
    func getFileExtension() -> String
    func getVolume() -> Float
    
    var isPlaying: Bool { get set }
}

extension Sound {
    func getVolume() -> Float { 1 }
    
}

struct BirdSound: Sound {
    func getTitle() -> String { "BirdSound" }
    func getFileName() -> String { "bird_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

struct HighWaySound: Sound {
    func getTitle() -> String { "HighWaySound" }
    func getFileName() -> String { "highway_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

struct WaterSound: Sound {
    func getTitle() -> String { "WaterSound" }
    func getFileName() -> String { "water_sound" }
    func getFileExtension() -> String { "mp3" }
    
    var isPlaying = false
}

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

// MARK: - 소리 구조
struct DownTempo: Sound {
    var tag = 0
    var soundTitle = "Down Tempo"
    
    func getTitle() -> String { "Down Tempo" }
    func getFileName() -> String { "Down Tempo" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Bonfire: Sound {
    var tag = 1
    var soundTitle = "Bonfire"
    
    func getTitle() -> String { "Bonfire" }
    func getFileName() -> String { "Bonfire" }
    func getFileExtension() -> String { "wav" }
    
    var volumeSize: Float = 1
}

struct Rain1: Sound {
    var tag = 2
    var soundTitle = "Rain 1"
    
    func getTitle() -> String { "Rain 1" }
    func getFileName() -> String { "Rain 1" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Rain2: Sound {
    var tag = 3
    var soundTitle = "Rain 2"
    
    func getTitle() -> String { "Rain 2" }
    func getFileName() -> String { "Rain 2" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct River: Sound {
    var tag = 4
    var soundTitle = "River"
    
    func getTitle() -> String { "River" }
    func getFileName() -> String { "River" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Waterfall: Sound {
    var tag = 5
    var soundTitle = "Waterfall"
    
    func getTitle() -> String { "Waterfall" }
    func getFileName() -> String { "Waterfall" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Forest: Sound {
    var tag = 6
    var soundTitle = "Forest"
    
    func getTitle() -> String { "Forest" }
    func getFileName() -> String { "Forest" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Wave1: Sound {
    var tag = 7
    var soundTitle = "Wave 1"
    
    func getTitle() -> String { "Wave 1" }
    func getFileName() -> String { "Wave 1" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Wave2: Sound {
    var tag = 8
    var soundTitle = "Wave 2"
    
    func getTitle() -> String { "Wave 2" }
    func getFileName() -> String { "Wave 2" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Wind1: Sound {
    var tag = 9
    var soundTitle = "Wind 1"
    
    func getTitle() -> String { "Wind 1" }
    func getFileName() -> String { "Wind 1" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Wind2: Sound {
    var tag = 10
    var soundTitle = "Wind 2"
    
    func getTitle() -> String { "Wind 2" }
    func getFileName() -> String { "Wind 2" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Cave: Sound {
    var tag = 11
    var soundTitle = "Cave"
    
    func getTitle() -> String { "Cave" }
    func getFileName() -> String { "Cave" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Bird: Sound {
    var tag = 12
    var soundTitle = "Bird"
    
    func getTitle() -> String { "Bird" }
    func getFileName() -> String { "Bird" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct CriketCrying: Sound {
    var tag = 13
    var soundTitle = "Criket Crying"
    
    func getTitle() -> String { "Criket Crying" }
    func getFileName() -> String { "Criket Crying" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Cicada: Sound {
    var tag = 14
    var soundTitle = "Cicada"
    
    func getTitle() -> String { "Cicada" }
    func getFileName() -> String { "Cicada" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Library: Sound {
    var tag = 15
    var soundTitle = "Library"
    
    func getTitle() -> String { "Library" }
    func getFileName() -> String { "Library" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Temple: Sound {
    var tag = 16
    var soundTitle = "Temple"
    
    func getTitle() -> String { "Temple" }
    func getFileName() -> String { "Temple" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Highway: Sound {
    var tag = 17
    var soundTitle = "Highway"
    
    func getTitle() -> String { "Highway" }
    func getFileName() -> String { "Highway" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Firework: Sound {
    var tag = 18
    var soundTitle = "Firework"
    
    func getTitle() -> String { "Firework" }
    func getFileName() -> String { "Firework" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Clock: Sound {
    var tag = 19
    var soundTitle = "Clock"
    
    func getTitle() -> String { "Clock" }
    func getFileName() -> String { "Clock" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Pencil: Sound {
    var tag = 20
    var soundTitle = "Pencil"
    
    func getTitle() -> String { "Pencil" }
    func getFileName() -> String { "Pencil" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

struct Fan: Sound {
    var tag = 21
    var soundTitle = "Fan"
    
    func getTitle() -> String { "Fan" }
    func getFileName() -> String { "Fan" }
    func getFileExtension() -> String { "mp3" }
    
    var volumeSize: Float = 1
}

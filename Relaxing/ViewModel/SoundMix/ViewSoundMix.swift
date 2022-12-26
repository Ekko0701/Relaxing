//
//  ViewSoundMix.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/12.
//

import Foundation
import UIKit

/**
 ViewSoundMix에 보여질 내용
 */
struct ViewSoundMix {
    /** 태그
        MainView에서의 순서 (indexPath.row)와 같음*/
    //let tag: Int
    /** 태그 타이틀 */
    let title: String
    /** Cell에 표시될 Title */
    //let titleLabel: String
    /** Cell에 표시될 Image*/
    let titleImage: UIImage
    /** Volume Size */
    var playerVolume: Float
    
    init(title: String, playerVolume: Float) {
        //self.tag = TitleInfo(rawValue: title)?.tag ?? 0
        self.title = title
        //self.titleLabel = TitleInfo(rawValue: title)?.titleLabel ?? ""
        self.titleImage = TitleInfo(rawValue: title)?.image ?? UIImage(systemName: "gear")!
        self.playerVolume = playerVolume
    }
}

/**
 Sound Title Enum
 Title에 해당하는 image 프로퍼티를 가지고 있다.
 */
enum TitleInfo: String {
    case BirdSound
    case HighWaySound
    case WaterSound
    
    case DownTempo
    case Bonfire
    case Rain1
    case Rain2
    case River
    case Waterfall
    case Forest
    case Wave1
    case Wave2
    case Wind1
    case Wind2
    case Cave
    case Bird
    case CriketCrying
    case Cicada
    case Library
    case Temple
    case Highway
    case Firework
    case Clock
    case Pencil
    case Fan
    
    
//    var tag: Int {
//        switch self {
//        case .BirdSound:
//            return 0
//        case .HighWaySound:
//            return 1
//        case .WaterSound:
//            return 2
//        }
//    }
    
//    var titleLabel: String {
//        switch self {
//        case .BirdSound:
//            return "새소리"
//        case .HighWaySound:
//            return "고속도로"
//        case .WaterSound:
//            return "물소리"
//        }
//    }
    
    var image: UIImage {
        switch self {
        case .BirdSound:
            return UIImage(named: "bird")!
        case .HighWaySound:
            return UIImage(named: "road")!
        case .WaterSound:
            return UIImage(named: "wave")!
        case .DownTempo:
            return UIImage(named: "Down Tempo_Icon")!
        case .Bonfire:
            return UIImage(named: "Bonfire_Icon")!
        case .Rain1:
            return UIImage(named: "Rain 1_Icon")!
        case .Rain2:
            return UIImage(named: "Rain 2_Icon")!
        case .River:
            return UIImage(named: "River_Icon")!
        case .Waterfall:
            return UIImage(named: "Waterfall_Icon")!
        case .Forest:
            return UIImage(named: "Forest_Icon")!
        case .Wave1:
            return UIImage(named: "Wave 1_Icon")!
        case .Wave2:
            return UIImage(named: "Wave 2_Icon")!
        case .Wind1:
            return UIImage(named: "Wind 1_Icon")!
        case .Wind2:
            return UIImage(named: "Wind 2_Icon")!
        case .Cave:
            return UIImage(named: "Cave_Icon")!
        case .Bird:
            return UIImage(named: "Bird_Icon")!
        case .CriketCrying:
            return UIImage(named: "Criket Crying_Icon")!
        case .Cicada:
            return UIImage(named: "Cicada_Icon")!
        case .Library:
            return UIImage(named: "Library_Icon")!
        case .Temple:
            return UIImage(named: "Temple_Icon")!
        case .Highway:
            return UIImage(named: "Highway_Icon")!
        case .Firework:
            return UIImage(named: "Firework_Icon")!
        case .Clock:
            return UIImage(named: "Clock_Icon")!
        case .Pencil:
            return UIImage(named: "Pencil_Icon")!
        case .Fan:
            return UIImage(named: "Fan_Icon")!
            
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "BirdSound": self = .BirdSound
        case "HighWaySound": self = .HighWaySound
        case "WaterSound": self = .WaterSound
        case "Down Tempo": self = .DownTempo
        case "Bonfire": self = .Bonfire
        case "Rain 1": self = .Rain1
        case "Rain 2": self = .Rain2
        case "River": self = .River
        case "Waterfall": self = .Waterfall
        case "Forest": self = .Forest
        case "Wave 1": self = .Wave1
        case "Wave 2": self = .Wave2
        case "Wind 1": self = .Wind1
        case "Wind 2": self = .Wind2
        case "Cave": self = .Cave
        case "Bird": self = .Bird
        case "Criket Crying": self = .CriketCrying
        case "Cicada": self = .Cicada
        case "Library": self = .Library
        case "Temple": self = .Temple
        case "Highway": self = .Highway
        case "Firework": self = .Firework
        case "Clock": self = .Clock
        case "Pencil": self = .Pencil
        case "Fan": self = .Fan
        default:
            return nil
        }
    }
}


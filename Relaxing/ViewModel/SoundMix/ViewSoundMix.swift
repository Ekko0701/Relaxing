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
    let tag: Int
    /** 태그 타이틀 */
    let title: String
    /** Cell에 표시될 Title */
    let titleLabel: String
    /** Cell에 표시될 Image*/
    let titleImage: UIImage
    /** Volume Size */
    var playerVolume: Float
    
    init(title: String, playerVolume: Float) {
        self.tag = TitleInfo(rawValue: title)?.tag ?? 0
        self.title = title
        self.titleLabel = TitleInfo(rawValue: title)?.titleLabel ?? ""
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
    
    var tag: Int {
        switch self {
        case .BirdSound:
            return 0
        case .HighWaySound:
            return 1
        case .WaterSound:
            return 2
        }
    }
    
    var titleLabel: String {
        switch self {
        case .BirdSound:
            return "새소리"
        case .HighWaySound:
            return "고속도로"
        case .WaterSound:
            return "물소리"
        }
    }
    
    var image: UIImage {
        switch self {
        case .BirdSound:
            return UIImage(systemName: "house")!
        case .HighWaySound:
            return UIImage(systemName: "gear")!
        case .WaterSound:
            return UIImage(systemName: "eraser")!
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "BirdSound": self = .BirdSound
        case "HighWaySound": self = .HighWaySound
        case "WaterSound": self = .WaterSound
        default:
            return nil
        }
    }
}

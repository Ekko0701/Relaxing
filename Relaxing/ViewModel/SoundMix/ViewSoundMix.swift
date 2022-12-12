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
    let titleLabel: String
    let titleImage: UIImage
    
    init(titleLabel: String) {
        self.titleLabel = titleLabel
        self.titleImage = TitleImage(rawValue: titleLabel)?.image ?? UIImage(systemName: "gear")!
    }
}

/**
 Sound Title Enum
 Title에 해당하는 image 프로퍼티를 가지고 있다.
 */
enum TitleImage: String {
    case BirdSound
    case HighWaySound
    case WaterSound
    
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

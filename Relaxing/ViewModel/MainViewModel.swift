//
//  MainViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

protocol MainViewModelType {
    // INPUT
    
    // OUTPUT
    var sampleDatas: [SoundItemModel] { get }
    var soundData: [Sound] { get }
}

class MainViewModel: MainViewModelType {
   
    // OUTPUT
    let sampleDatas: [SoundItemModel]
    let soundData: [Sound]
    
    init() {
        sampleDatas = [
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "새소리"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "고속도로 소리"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
        ]
        
        soundData = [
            BirdSound(),
            HighWaySound(),
            WaterSound(),
            HighWaySound(),
        ]
    }
}

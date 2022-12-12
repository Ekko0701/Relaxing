# Relaxing

### 2022.12.09
- 폰트 추가 및 Extension 설정
- SnapKit, Then 라이브러리 추가 (SPM)
- RxSwift, RxCocoa, RxViewController 추가 (CocoaPods)

- CollectionView 추가 및 itemSelect 테스트 진행
- AVFoundation을 이용해 사운드 재생 테스트 완료
- Sound Manager는 싱글톤 패턴으로 구성

### 2022.12.10
- SoundManager의 play 메소드 구현 완료 with Rxswift
    - 여러 player가 동시에 동작 가능하도록 구현
- ControlBarView 생성 및 Play 버튼 메소드 구현 
    - RxSwift를 이용해 구현
- Item 선택시 배경 색상 변경 구현
- 재생중인 소리가 있는지 여부에 따라 Control Bar의 Play 아이콘 변화 구현
    - Sound Play 여부 및 재생 목록(SoundManager의 audioPlayers)의 모든 player가 재생중인지 검사해 구현함.

### 2022.12.11
- 코드 정리, 주석 추가
- PanModal 라이브러리 추가 (SPM)
- Control Bar View의 Sound Mix Button 액션 구현 
    - MainViewController ( rx.tap ) 
    - -> ViewModel (soundMixButtonTouch)
    - -> ViewModel (soundMixButtonTouching)
    - -> ViewModel (showSoundMixVC)
    - -> MainViewController ( present VC ) (panModal)
- SoundMixController UI 구성 진행중

### 2022.12.12
- Audio가 백그라운드 상태에서도 작동하도록 하기 위해 TARGETS - Capability - BackgroundMode에서 '''Audio, Airplay, and Picture in Picture''' 활성화
    - Issue : 기기가 무음 모드 또는 앱이 백그라운드 상태에서 오디오가 재생되지 않는다.
- AppDelegate에서 앱이 실행될때 AVAudioSession으로 오디오를 사용할 방식을 설정해서 해결.
- SoundMixView의 volumeSlider로 volume 조절 구현 (slider.rx.value)
    - Issue : SoundMixVC가 다시 초기화 되면 volumeSlider의 value도 다시 초기화됨. -> ViewSoundMix에 volume 프로퍼티 추가 필요.

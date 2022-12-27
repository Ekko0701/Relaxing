<p align="left">
    <img src= "https://github.com/Ekko0701/Relaxing/blob/main/Chilling%20%E1%84%8C%E1%85%A1%E1%84%85%E1%85%AD/Clilling%20ScreenShots/Chilling%20Logo.png" width="15%">
</p>

# Relaxing<br/>
[App Store](https://apps.apple.com/us/app/%EC%B9%A0%EB%A7%81/id1661592110?platform=iphone)

## 미리보기
<p align="left">
    <img src= "https://github.com/Ekko0701/Relaxing/blob/main/Chilling%20%E1%84%8C%E1%85%A1%E1%84%85%E1%85%AD/Clilling%20ScreenShots/%E1%84%8B%E1%85%A2%E1%86%B8%E1%84%89%E1%85%B3%E1%84%90%E1%85%A9%E1%84%8B%E1%85%A5%20%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA.png" width="80%">
</p>


## Introduce
공부, 수면, 명상과 같은 활동을 할 때 빗소리, 새소리, 물 흐르는 소리 등 차분한 소리를 필요로 한 적이 있을 것이다. 이 앱은 단순히 차분한 소리를 재생시킬 뿐만이 아니라 여러 소리를 섞어서 사용할 수 있다. 여러 소리를 섞고 각 소리의 볼륨을 조절해 나만의 소리를 만들어보자.
<br/>
<br/>
<br/>

## 개발 상세
- 홈 화면에서 소리를 터치하면 재생됩니다.
- 여러 소리를 동시에 재생할 수 있습니다.
- 우측 하단의 버튼을 누르면 재생, 믹스, 타이머 버튼을 사용할 수 있습니다.
    - 재생 버튼을 누르면 현재 재생 중인 모든 사운드를 일시 정지시킵니다.
    - 믹스 버튼을 누르면 현재 재생 중인 사운드 목록이 나오고 각각의 볼륨을 조절할 수 있습니다.
        - 저장 버튼을 눌러 현재 재생 중인 사운드 목록을 저장할 수 있습니다.
    - 타이머 버튼을 누르면 사운드 종료 타이머를 설정할 수 있습니다.
- 믹스 탭에서 저장한 사운드 목록을 확인하고 재생시킬 수 있습니다.
<br/>
<br/>
<br/>

## 오픈 소스 라이브러리 (CocoaPods, SPM)
- Lottie
- PanModal
- Realm
- SnapKit
- Then
- RxSwift
- RxCocoa
- RxViewController
- RxGesture
<br/>
<br/>
<br/>

## 개발 일지
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
    - Issue1 : 기기가 무음 모드 또는 앱이 백그라운드 상태에서 오디오가 재생되지 않는다. (해결)
- AppDelegate에서 앱이 실행될때 AVAudioSession으로 오디오를 사용할 방식을 설정해서 해결.
- SoundMixView의 volumeSlider로 volume 조절 구현 (slider.rx.value)
    - Issue2 : SoundMixVC가 다시 초기화 되면 volumeSlider의 value도 다시 초기화됨. -> ViewSoundMix에 volume 프로퍼티 추가 필요.(해결)

### 2022.12.14
- Realm 추가 (SPM)
- SoundMixController에 사운드 믹스 저장 Button 추가 및 viewModel과 바인딩 완료.
- Realm 데이터 저장을 위한 Struct 생성
    - Realm에서는 Dictionary와 Array 대신 List를 사용해 soundMix 목록을 만들었다. (해결)
- MixViewController UI 구성 진행중
- MixViewController 테이블뷰에 realm에서 받아온 데이터(SoundMix)를 ViewMix로 파싱 후 보여줌
- realm에서 받아온 SoundMix의 정보로 SoundManager에서 재생 구현 완료 
    - Title, volume을 기반으로 사운드 플레이어를 설정한다.
- Issue3 : mainVC에서 재생 목록에 플레이어 추가 후 믹스로 추가 후 mixVC를 로드하면 최근에 추가한 믹스가 보이지 않는다.
    - viewWillAppear에서 viewModel을 재정의해 realm에서 데이터를 가져오고 tableView을 리로드했다. (해결)
    - 시도해볼것 : RxViewController를 사용해 viewWillAppear.rx 로 viewModel에 viewWillAppear 했다는 이벤트를 전달한다. -> realm에서 데이터를 읽어온다. -> tableView를 리로드 한다.
- Issue4 : mixVC에서 믹스를 플레이하면 mainVC의 ControlBar의 재생목록에 잘 추가되있다. 그러나 ControlBar의 play 아이콘은 바뀌지 않았다. (해결)

### 2022.12.16
- MainView viewWillAppear때 현재 재생중인 사운드의 isSelect를 true로 변경하고, CollectionView를 reload를 함으로써 SoundMix로 재생한 사운드가 mainView에 표시되지 않는 문제를 해결함.
    - mainVC에 viewWillAppear.rx를 추가해 viewWillAppear 할때마다 viewModel로 이벤트를 전달한다. 이벤트를 reloading이 구독하고 있고 사운드 선택 여부 (isSelected)를 체크한다. 이벤트를 전달 받음과 동시에 collectionView를 reload하는 reloadingCollectionView에 이벤트를 전달한다.
- MainViewModel의 reloading subject에 이벤트가 전달되면 plaingState()를 실행해 ControlBar의 play 아이콘 활성화 여부를 체크했다. (Issue4 해결)

### 2022.12.17
- MainViewModel의 applyMixPlayerToCollection() 수정
    - isSelected를 먼저 전부 false 처리를 해준후 아래에서 재생 중인 사운드의 isSelected를 true로 바꿔준다.
- 사운드 목록 수집
- 메인뷰 UI 구상

### 2022.12.18
- mix 저장 버튼 터치시 textField가 포함된 alert 보여주고 mix의 title 입력 구현
- SoundManager의 audioPlayers(재생목록)에 플레이어가 없을때 믹스 추가 버튼을 눌러도 아무 동작 하지 않도록 변경
- App Icon 제작 및 적용
- Timer 버튼 액션 추가
- TimerPopUpViewController 구성 진행중

### 2022.12.19
- TimerManager(Singleton)으로 Timer관리하도록 설계
    - TimerPopUpViewController에서 countDown DatePicker로 타이머 설정 후 시작 버튼 터치시 TimerManager의 Timer실행.
    - 종료되면 SoundManager의 audioPlayers(재생목록)의 모든 player 중지 및 timer.invalidate()
- UI 와이어프레임 제작 (Figma)

### 2022.12.20
- LaunchScreen 이미지 제작, 추가
- Localizing으로 다국어 처리(en,ko) 완료
- MixViewController에서 TableView 좌로 슬라이드시 Mix 삭제 구현
    - TableView Editing을 사용해 editingStyle이 delete라면 viewModel의 deleteMix로 indexPath Event를 전달해 먼저 viewModel에서 realm 데이터 삭제, soundItems 요소 삭제 후 tableView.deleteRows

### 2022.12.21
- ControlView 추가, Open / Close 애니메이션 구현, Icon 추가
- 전체 UI 변경중
- TimerPopUpViewController 나가기 Button과 배경을 터치했을때 dismiss 액션 구현 완료
    - 팝업뷰를 dismiss하는 모든 이벤트는 viewModel의 dismissTimerView Subject로 전달되어 처리된다. -> 나중에 다른 event 추가할때 편의성을 위함
- Timer 실행중 여부를 판단해 실행중인 경우에는 TimerPopUpView에 timerActivatedView가 나타나 타이머가 진행중임을 보여준다. Timer가 끝나면 timerActivatedView가 없어진다.
    - TimerManager에 testOn이라는 subject가 Timer실행중 여부에 따라 Bool값을 받는다. testOn을 TimerPopUpViewModel에서 구독하고 그 값을 timerActivating에 전달한다. TimerActivated = timerActivating으로 TimerViewController에서 timerActivated를 bind해 사용한다.
- Issue 5: Timer가 종료되어도 Main CollectionView의 isSelected 값이 변경되지 않는다.
    - 시도해볼것 -> 타이머가 끝나는 순간 mainViewModel의 reloading에 이벤트를 보내 실행해 주자. (applyMixPlayerToCollection, playingState)

### 2022.12.22
- Issue5 해결 완료
- 타이머 진행중일때 애니메이션을 보여주기 위해 Lottie 추가 (SPM)
- TimerAnimationView 구성 요소 (AnimationView, Label...) 추가 및 viewModel과 Bind
- Issue6 : AnimationView의 cancel 버튼을 누르면 재생목록이 전부 삭제되고 플레이어가 종료된다. 아마도 viewModel에서 잘못 연결된것같다.

### 2022.12.23
- Issue6 해결 완료
    - 타이머 시작, 종료, 캔슬 세가지 이벤트가 timerInProgress Observable과 연결되어 있었는데 종료와 캔슬이 다르게 동작해야 했기에 새로운 Observable을 만들어 이벤트를 나눴다.
- Timer 진행중일때 TimerPopUpView가 처음 보여지면 DataPicker가 보여지는 문제 해결

### 2022.12.25
- MPRemoteCommandCenter, MPNowPlayingInfoCenter 를 사용해 제어센터에서 재생, 일시정시 가능하도록 구현
- 공유마당에서 사운드 서치 및 앱에 추가
- SettingView 추가 및 레이아웃 설정
    - TableView위에 NavigationBarController가 있도록 보이게 UINavigationBarAppearance를 설정해 구현
        - configureWithTransparentBackground(), backgroundColor, backgroundEffect
- SettingView TableViewCell과 Header에 들어갈 데이터 enum으로 설정 및 viewModel에서 관리하도록 구현

### 2022.12.26
- SettingViewController의 ViewModel을 TableViewModel, SettingViewModel로 나눔
    - TableViewModel에서는 TableView 데이터 관련 로직을 처리, SettingViewModel에서는 나머지 로직을 처리 (터치 이벤트, 화면 전환..)
- LicenseViewController, LicenseViewModel 구현 완료
    - WebKit의 WKWebView를 이용히 License 정보를 가지는 노션 웹페이지를 보여줌.
- 앱 기본 Apperance를 다크 모드로 수정
- 사운드 파일, 사운드 아이콘 파일 추가 및 적용 완료
- UI 수정 완료
- Localizing 완료
- WKWebView 로드 에러 처리 구현
- 라이브러리 라이센스 정보 추가 완료

### 2022.12.27
- 앱 심사 및 배포 완료 [App Store](https://apps.apple.com/us/app/%EC%B9%A0%EB%A7%81/id1661592110?platform=iphone)

# AR-GPT-ImageDetection

AR 을 활용하여 이미지를 인식하고, openAI Vision API 를 활용해 인식한 이미지에 대한 정보를 출력하는 앱입니다.

<br/>

## 1. 테스트 방법

openAI API 를 활용하기 위해서는 AR-GPT-ImageDetection/Supports/ 폴더 내 Config.xcconfig 파일을 생성하여 OPENAI_API_KEY 라는 이름으로 apiKey 를 등록해야 합니다.

<br/>


### 마커 등록용 이미지 예시

아래 이미지를 다운받아 마커 등록에 활용할 수 있습니다.

|큐알코드|텍스트|로고|
|---|---|---|
|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/e1f561a7-605f-467f-a6fe-1fcce4ed4d44" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/716d59d4-d796-4e2f-884a-7a313af6bfd0" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/b9378424-66f6-4c81-8eb4-2d27e9c46037" width="300"/>|

<br/>

## 2. 예시 화면

|이미지 등록|이미지 인식|이미지 정보 출력|
|---|---|---|
|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/3acffed4-732e-45fd-ae71-c267aada317e" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/57677370-a844-433d-be63-0fec877f0f68" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/9aaa051a-63aa-48b4-a60b-d13d608f1ad8" width="300"/>|

<br/>

## 3. 기능 설명

### 이미지 등록
이미지 등록 화면에서 + 버튼을 클릭하여 등록 화면으로 넘어갈 수 있습니다. 

(초기 구동 시 등록된 이미지가 없으므로 아래 이미지와 달리 빈 화면이 노출됩니다.)

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/c59a8abc-2072-4e39-8d82-6e309fbf5038" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/486f2b8e-c74d-47a9-bfc0-d024f85834cc" width="300"/>

<br/>

이미지 버튼을 클릭해 기본 사진앱의 사진 중에서 등록할 이미지를 선택할 수 있습니다.

사진을 등록하고 기타 정보를 입력하여 마커 이미지를 등록합니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/279e0b1d-05f5-4b11-a11e-7d28a94e4dfe" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/c235ec54-6d5d-4891-b6e5-7f88fb6f536b" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/d2248cb0-b415-4211-8391-90bcd49e352d" width="300"/>

<br/>

### 이미지 업데이트

수정하고자 하는 이미지를 클릭하면 수정 화면으로 넘어갈 수 있습니다. 수정 화면은 기본적으로 이미지 등록 화면과 동일한 구성을 가지고 있습니다.

<br/>

### 이미지 삭제

삭제하고자 하는 이미지를 꾸욱 누르면 삭제 여부를 물어보는 알럿이 뜨게 됩니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/0020a6ac-d582-4821-9ad9-b5aff24da095" width="300"/>

<br/>

### 이미지 인식

등록한 마커 이미지를 기반으로 사물을 인식합니다. 인식하고자 하는 사물은 2차원 평면이어야 합니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/e38746b9-bb06-4eff-8f11-40e57cbd81cf" width="300"/>

<br/>

사물을 인식하면 위와 같이 노란색 테두리가 나타나며, 미리 등록한 정보가 우측에 표현됩니다.

인식한 사물을 화면에서 터치하면 모달 창을 통해 해당 이미지에 대한 AI의 답변을 확인할 수 있습니다. (답변까지 통상 10초 이상 소요)

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/321c2260-8f3b-49b4-88f8-0dea4fbb441c" width="300"/>

<br/>

## 4. 프로젝트 구조
```
.
├── App
│   ├── AGITabBarController.swift  // 탭바 컨트롤러
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── CoreData
│   ├── MarkerImageMO+CoreDataClass.swift
│   ├── MarkerImageMO+CoreDataProperties.swift
│   ├── MarkerImageMO+Mapping.swift
│   ├── MarkerImageModel.xcdatamodeld
│   │   └── MarkerImageModel.xcdatamodel
│   │       └── contents
│   └── Utility
│       ├── Implementation
│       │   └── MarkerImageManager.swift  // 코어데이터와 마커이미지 도메인을 연동한 CRUD 기능
│       ├── Interface
│       │   └── MarkerImageManageable.swift
│       └── Model
│           └── MarkerImage.swift  // 앱 내부에서 활용할 마커이미지 도메인
├── Foundation
│   └── UIImage++.swift  // 이미지 리사이징 로직
├── ImageDetection  // 이미지 인식 탭 관련 기능
│   ├── Controller
│   │   ├── GPTInformationViewController.swift  // Vision API 응답 관련 모달 뷰컨트롤러
│   │   └── ImageDetectionViewController.swift  // 이미지 인식 뷰컨트롤러
│   ├── Model
│   │   └── MarkerProvider.swift  // ARReferenceImage 로드 기능 제공
│   └── Utility
│       ├── Implementation
│       │   ├── ColoredSymbolProvider.swift  // 심볼 이미지 컬러 변환 기능
│       │   ├── SnapshotGenerator.swift  // 스크린샷(스냅샷) 촬영 기능
│       │   └── TextImageGenerator.swift  // 텍스트가 삽입된 이미지 생성 기능
│       └── Interface
│           ├── ColoredSymbolProtocol.swift
│           ├── SnapshotCreatable.swift
│           └── TextImageCreatable.swift
├── MarkerRegistration
│   ├── Controller
│   │   ├── MarkerImageCollectionViewController.swift  // 이미지 등록 탭 뷰컨트롤러(마커이미지 콜렉션 뷰)
│   │   └── MarkerRegistrationViewController.swift  // 이미지 등록 모달 뷰컨트롤러(마커이미지 등록 기능)
│   └── View
│       └── InputFieldView.swift
├── Network
│   ├── API
│   │   └── VisionAPI.swift
│   ├── Error
│   │   └── NetworkError.swift
│   ├── Foundation
│   │   └── NetworkManager.swift
│   ├── Model
│   │   ├── VisionRequestModel.swift  // VisionAPI DTO
│   │   └── VisionResponseModel.swift  // VisionAPI DTO
│   ├── Service
│   │   └── VisionAPIService.swift  // API 요청 서비스 클래스
│   └── Utility
│       └── APIConfig.swift  // API 관련 문자열 데이터
├── Resources
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   └── Contents.json
│   └── Base.lproj
│       └── LaunchScreen.storyboard
└── Supports
    ├── Config.xcconfig
    └── Info.plist
```

<br/>

## 5. 해결한 문제

- 

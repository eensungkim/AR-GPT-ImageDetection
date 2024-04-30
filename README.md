![IMG_1625](https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/42d350b9-549c-4ac1-b6fb-fe89655a07b5)# AR-GPT-ImageDetection

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
|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/7e21863b-80a4-4800-bc76-55cdccc19225" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/57677370-a844-433d-be63-0fec877f0f68" width="300"/>|<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/2b80b65f-2870-4941-8aa2-12cd7a1f96d7" width="300"/>|

<br/>

## 3. 기능 설명

### 이미지 등록
이미지 등록 화면에서 + 버튼을 클릭하여 등록 화면으로 넘어갈 수 있습니다. 

(초기 구동 시 등록된 이미지가 없으므로 아래 이미지와 달리 빈 화면이 노출됩니다.)

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/c59a8abc-2072-4e39-8d82-6e309fbf5038" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/4bed4d97-234d-46f5-aa3a-604f8ed5f042" width="300"/>

<br/>

사진 등록 버튼을 클릭해 기본 사진앱의 사진 중에서 등록할 이미지를 선택할 수 있습니다.

직접 촬영 버튼을 클릭해 카메라로 대상이 될 마커를 직접 촬영하여 등록할 수 있습니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/46c9fe9c-ec9e-4b2f-b2f5-fd7f0d7bca5b" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/4653941e-0987-4c99-a8aa-4c23bb22de6f" width="300"/>

기타 정보를 입력하여 마커 이미지를 등록합니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/fc25842d-da56-43af-971e-db8007883b48" width="300"/>

<br/>

### 이미지 업데이트

수정하고자 하는 이미지를 클릭하면 수정 화면으로 넘어갈 수 있습니다. 수정 화면은 기본적으로 이미지 등록 화면과 동일한 구성을 가지고 있습니다.

<br/>

### 이미지 삭제

삭제하고자 하는 이미지를 꾸욱 누르면 삭제 여부를 물어보는 알럿이 뜨게 됩니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/0020a6ac-d582-4821-9ad9-b5aff24da095" width="300"/>

<br/>

### 이미지 인식

등록한 마커 이미지를 기반으로 사물을 인식합니다. 인식하고자 하는 사물은 2차원 평면에 위치해야 합니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/57677370-a844-433d-be63-0fec877f0f68" width="300"/>

<br/>

사물을 인식하면 위와 같이 노란색 테두리가 나타나며, 미리 등록한 정보가 우측에 표현됩니다.

인식한 사물을 화면에서 터치하면 모달 창을 통해 해당 이미지에 대한 AI의 답변을 확인할 수 있습니다. (답변까지 통상 10초 이상 소요)

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/2b80b65f-2870-4941-8aa2-12cd7a1f96d7" width="300"/>

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
│   ├── UIImage++.swift  // 이미지 리사이징 로직
│   └── UIViewController++.swift  // 알럿 컨트롤러
├── ImageDetection  // 이미지 인식 탭 관련 기능
│   ├── Controller
│   │   ├── GPTInformationViewController.swift  // Vision API 응답 관련 모달 뷰컨트롤러
│   │   └── ImageDetectionViewController.swift  // 이미지 인식 뷰컨트롤러
│   ├── Error
│   │   ├── ImageError.swift
│   │   └── SnapshotError.swift
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
│   │   ├── MarkerImageCaptureViewController.swift  // 카메라 뷰컨트롤러(마커이미지 촬영 기능)
│   │   ├── MarkerImageCollectionViewController.swift  // 이미지 등록 탭 뷰컨트롤러(마커이미지 콜렉션 뷰)
│   │   └── MarkerRegistrationViewController.swift  // 이미지 등록 모달 뷰컨트롤러(마커이미지 등록 기능)
│   └── View
│       ├── CameraPreviewView.swift
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

이미지 크롭 시 발생했던 문제
- 배율 문제
    - UIView 의 frame: CGFloat 값과 실제 이미지의 사이즈: CGFloat 값은 서로 다른 단위를 가지고 있습니다.
    - 따라서 UIView 와 관련된 frame 의 값을 가져와서 이미지를 가공하려면 배율을 계산하여 수치들을 조정해 주어야 합니다.
    - 아래 코드에서처럼 카메라뷰의 너비를 가져온 뒤에 이미지의 실제 너비에서 나누어 주는 것으로 배율을 구하여 문제를 해결했습니다.

```swift
// MarkerImageCaptureViewController.swift 파일

let imageWidth = CGFloat(cgImage.height)  // 이미지의 실제 크기
let imageHeight = CGFloat(cgImage.width)
        
let cameraPreviewViewWidth = cameraPreviewView.bounds.width  // 특정한 UIView 의 크기
let scale = imageWidth / cameraPreviewViewWidth  // 이미지 실제 크기에서 UIView 의 크기를 나누어 배율을 구함
```

- 좌표계 문제
    - 위의 코드를 살펴보면 imageWidth 라는 변수에 cgImage 의 높이를 할당해 주었습니다.
    - 이는 cgImage 로 변환하면서 좌표계가 달라지기 때문입니다. 카메라 촬영 시를 기준으로 너비가 cgImage 의 높이가 되고, 높이는 cgImage 의 너비로 변환되는 식입니다. 촬영한 이미지가 반시계방향으로 회전했다고 볼 수 있습니다.
      - 이때 좌표계의 시작점과 방향도 달라집니다. UIView 의 좌표계가 좌상단(0,0)에서 출발해서 우하단(x,y) 방향으로 값이 늘어나게 된다면, cgImage 의 좌표계는 좌하단(0,0)에서 출발해서 우상단(x,y) 방향으로 늘어나는 형태입니다.
    - 따라서 기존 뷰를 기준으로 하여 x, y 좌표의 값을 그대로 가져와 활용하는 경우, y 좌표 계산에 문제가 생기게 됩니다.
    - 캡처하고자 하는 영역을 카메라뷰의 중앙에 고정했기 때문에, 이미지의 높이와 캡처 영역의 높이를 활용해 문제를 해결했습니다.

```swift
// 좌표계 변경에 따라 높이와 너비 값을 서로 바꾸어 줌.
let imageWidth = CGFloat(cgImage.height)
let imageHeight = CGFloat(cgImage.width)
        
let cameraPreviewViewWidth = cameraPreviewView.bounds.width
let scale = imageWidth / cameraPreviewViewWidth

// 크롭 영역의 frame 값        
guard let maskLayerFrame = overlayView.subviews.first?.frame else { return }

// 이미지의 높이를 절반으로 나누고, 크롭 영역의 높이를 비율에 따라 곱한 뒤 2로 나눈 뒤, 전자에서 후자를 빼어 시작점을 확인       
let realCropX = (imageHeight / 2) - (maskLayerFrame.size.height * scale / 2)
let realCropY = maskLayerFrame.origin.x * scale
let realCropWidth = maskLayerFrame.size.height * scale
let realCropHeight = maskLayerFrame.size.width * scale
let realCropRect = CGRect(x: realCropX, y: realCropY, width: realCropWidth, height: realCropHeight)
```

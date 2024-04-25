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

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/c59a8abc-2072-4e39-8d82-6e309fbf5038" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/486f2b8e-c74d-47a9-bfc0-d024f85834cc" width="300"/>

<br/>

이미지 버튼을 클릭해 기본 사진앱의 사진 중에서 등록할 이미지를 선택할 수 있습니다.

사진을 등록하고 기타 정보를 입력하여 마커 이미지를 등록합니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/279e0b1d-05f5-4b11-a11e-7d28a94e4dfe" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/c235ec54-6d5d-4891-b6e5-7f88fb6f536b" width="300"/><img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/d2248cb0-b415-4211-8391-90bcd49e352d" width="300"/>

<br/>

### 이미지 삭제

삭제하고자 하는 이미지를 꾸욱 누르면 삭제 여부를 물어보는 알럿이 뜨게 됩니다.

<img src="https://github.com/eensungkim/AR-GPT-ImageDetection/assets/73898006/0020a6ac-d582-4821-9ad9-b5aff24da095" width="300"/>

<br/>

## 4. 프로젝트 설명


# RememberTest

<img src="https://user-images.githubusercontent.com/84484505/193732363-614337df-9edb-43c5-b64a-69f3fa7d5aa4.png" width="200" height="400"/> <img src="https://user-images.githubusercontent.com/84484505/193732369-85d4addf-81ce-449e-a131-53efbd5c9878.png" width="200" height="400"/> <img src="https://user-images.githubusercontent.com/84484505/193732376-72c41e0c-bf0f-43c0-a331-55dc112278a5.png" width="200" height="400"/>

1. API로 "최"를 검색한 화면
2. 로컬에 저장되어 있는 항목 화면 (입력값이 빈 값인경우 출력을 하도록 조정해 두었습니다.)
3. 로컬 저장항목중 "최"를 검색한 화면


## 작업 체크 사항 - 드라마앤컴퍼니(리멤버)_iOS_과제.pdf
### 기본 사항
- [x] Target OS 버전 - 13.0
- [x] SwiftUI가 아닌 UIKit로 구현
- [x] Device Orientation지원은 Portrait
- [x] 코드 작업은 Swift로만 작성
- [x] Xcode와 Swift버전은 최신 버전 - Xcode 14.0.1
- [x] github의 open api를 활용하여 사용자를 검색하고, 즐겨찾기 관리
  - https://docs.github.com/en/rest/search#search-users
  - https://docs.github.com/en/rest/users/users#get-a-user
- [x] 즐겨찾기 목록에 추가/제거 - 앱을 삭제하기 전까지 영구적으로 저장 - Realm으로 구성
- [x] 검색어 종류는 사용자의 이름으로 제한

### API 검색화면
- [x] 사용자의 목록을 출력 - 정렬은 API 응답 그대로 반영
- [x] 아이템뷰는 프로필 이미지, 사용자 이름, 즐겨찾기 여부 확인
- [x] 아이템뷰는 즐겨찾기의 추가, 제거 할수 있느 버튼 제공 - Tap시 화면에 갱신 및 즐겨찾기 반영

### 로컬 즐겨찾기 검색화면
- [x] 아이템뷰는 API 검색화면과 동일
- [x] 즐겨찾기 목록은 이름순으로 정렬
- [x] 이름의 맨 앞글자(초성)를 기준으로 변화가 있는곳에 Header를 보여줍니다.


## Architecture - MVVM을 기본으로 작업

### Common : extension처리
- 컨트롤 Publisher
- 라벨 강조 처리
- 문자열 연산

### ViewModel: 
- Model : 모델 
- GitHubAPI: github api 통신 연결
- GitHubManager: VM
- GitHubWrapper: 이름을 받아오기 위한 기본구조 -> Kingfisher와 같은 (label.gh.setName)

### Head: 상위 탭과 검색입력에 대한처리
- RTabs : 탭 컨트롤 
- HeadVC: 탭과 검색항목 관리

### List: API, 로컬등의 목록 표시 
- ListAPIVC:   "API 검색화면" 표시 - 리스트 형태
- ListLocalVC: "로컬 즐겨찾기 검색화면" 표시 - 헤더 리스트 형식으로 정렬 및 목록 표시
- ListCell:    "아이템 뷰" 표시 - 프로필 이미지, 사용자 이름, 즐겨찾기 여부 확인

### ViewController: 화면 전체에 대한 표시
- 각 항목들에 대한 연결 및 탭의 관리
- Subscriber 처리

## 향후 개선 사항 
- Autoresize 부분을 Autolayout으로 개선 - SnapKit 사용
- GitHubAPI 부분의 고도화 작업 (Service, Storage 분리) - Alamofire 사용등
1. 단말별 조정 작업 (키보드 크기에 따른 테이블뷰의 ContentInset 조정 작업)
2. 오류상황에 대한 예외 처리 및 팝오버 ( 네트워크 오류등 )
3. 검색 결과 없을때의 피드백 필요 (팝오버 또는 “내용 없음”)
4. 검색된 카운트 표시 (현재로딩된 항목표시)
5. 검색시 시간이 걸릴때 표시 
6. 검색의 다음 페이지 연결
7. 검색 결과에 대한 캐시 작업
8. 이름받기에 대한 2차 캐시 및 UILabel과 분리 작업
9. 사용자 상세 보기 화면 구성

## 사용한 프레임워크 - SPM으로 연결이 되어있습니다.
- Realm: 즐겨찾기등에 사용
- Kingsfisher: 이미지 출력에 사용
- Then: 오브젝트 초기화시에 사용

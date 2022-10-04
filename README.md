# RememberTest

<img src="https://user-images.githubusercontent.com/84484505/193732363-614337df-9edb-43c5-b64a-69f3fa7d5aa4.png" width="200" height="400"/> <img src="https://user-images.githubusercontent.com/84484505/193732369-85d4addf-81ce-449e-a131-53efbd5c9878.png" width="200" height="400"/> <img src="https://user-images.githubusercontent.com/84484505/193732376-72c41e0c-bf0f-43c0-a331-55dc112278a5.png" width="200" height="400"/>

1. API로 "최"를 검색한 화면
2. 로컬에 저장되어 있는 항목 화면 (입력값이 빈 값인경우 출력을 하도록 조정해 두었습니다.)
3. 로컬 저장항목중 "최"를 검색한 화면


## 작업 체크 사항
[x] 



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
- ListAPIVC: 리스트 형태로 검색 목록 표시
- ListLocalVC: 헤더 리스트 형식으로 정렬 및 목록 표시
- ListCell 검색된 항목에 한 단위 대한 표시, 즐겨찾기 처리

### ViewController:
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

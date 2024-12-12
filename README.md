# pokePhoneBook

## 📱 소개
**pokePhoneBook**은 이름, 전화번호, 그리고 랜덤 이미지를 사용한 연락처 관리 앱입니다.  
**MVC 패턴**을 기반으로 설계되었으며, **CoreData**를 활용하여 로컬 저장소에 연락처 정보를 저장하며, **Alamofire**를 사용하여 외부 **Pokemon API**에서 포켓몬 데이터를 가져왔습니다.
그리고 이를 기반으로 연락처를 생성, 수정, 삭제 및 조회할 수 있습니다.


## ⚙️ 주요 기능
- **연락처 생성**: 이름, 전화번호 입력 및 랜덤 이미지 추가.
- **랜덤 이미지 생성**: Pokemon API를 통해 무작위로 이미지를 가져와 적용.
- **저장된 연락처 보기**: CoreData에 저장된 연락처를 리스트로 확인.
- **연락처 수정**: 선택한 연락처의 이름, 번호, 이미지를 변경.
- **연락처 삭제**: 선택한 연락처 삭제.

---

## 💿 버전
- 언어 : **Swift 5**
- 버전 : **Xcode 16.1**
- 아키텍처 : **MVC (Model-View-Controller)**
- 외부 API : [PokeAPI](https://pokeapi.co)

## 🛠️ 사용 기술
- **UIKit**: 사용자 인터페이스 설계(UI 구현)
- **CoreData**: 데이터의 로컬 저장 및 관리
- **Alamofire**: 네트워킹 및 API 호출
- **SnapKit**: UI 레이아웃 작성의 간결화

## 📁 프로젝트 구조 (MVC 패턴)

```plaintext
pokePhoneBook
├── **Model**
│   ├── CoreDataManager         // CoreData 관리 및 데이터 처리 로직
│   ├── DataSource              // 데이터 모델 (연락처 구조체)
│   ├── Mode                    // View 모드(enum): add, view
│   ├── PokemonData             // Pokemon API 응답 데이터 구조체
│   └── ProfilesImageManager    // Pokemon API를 통한 이미지 로딩
│
├── **View**
│   ├── EnrolView               // 연락처 상세 및 수정 화면
│   ├── MainView                // 메인 연락처 리스트 화면
│   └── TableViewCell           // 연락처 리스트의 셀
│
├── **Controller**
│   ├── MainViewController      // 메인 화면 (연락처 리스트) 로직
│   └── PhoneBookViewController // 연락처 추가 및 수정 화면 로직
│
├── AppDelegate
├── SceneDelegate
├── Assets.xcassets
└── Info.plist
```

---

## 🎯 트러블슈팅
자세한 트러블슈팅 내용은 아래 링크에서 확인할 수 있습니다. 
[🎯트러블슈팅 페이지](https://velog.io/@jeffapd_/project%ED%8F%AC%EC%BC%93%EB%AA%AC-%EC%97%B0%EB%9D%BD%EC%B2%98)

---


# 살려줘 식물!
# 가정용 식물 관리 앱
## 개발 환경
* 서버 - AWS(Linux Ubuntu/Node.js(express))
* 클라이언트 - flutter, dart
* 데이터베이스 - MySQL(본인 synology nas에서 작동)
* 구조 - 3계층 구조(클라이언트 <-> AWS(Ubuntu Linux/Node js) <-> Synology Nas(MySQL))
* 네트워크 - dio (Restful API)

** 현재 구현 된 기능 : plant CRUD

** 미구현 기능 : 식물 AI (사진으로 종류 알아 내기), 물주기 알림, 사물 인터넷(물주기) 등

---

## 1. 메인 화면
* 등록 된 식물 사진을 표시, 해당 식물의 사진을 클릭하면 그 식물의 관리 페이지로 이동
<img src="https://user-images.githubusercontent.com/79705809/109412546-f6cf7a80-79eb-11eb-90ee-744822c300b5.jpg"  width="324" height="720">

* 카드 메뉴를 통해 식물 추가, 식물 관리 페이지로 이동

---

## 2. 식물 추가 화면
* 갤러리/카메라를 선택하여 이미지 추가 가능

<img src="https://user-images.githubusercontent.com/79705809/109412787-58441900-79ed-11eb-9857-ec654999d047.jpg"  width="324" height="720">

* 이미지 없이 등록하려 할 경우 예외처리

<img src="https://user-images.githubusercontent.com/79705809/109412796-65f99e80-79ed-11eb-98f6-e96c4e84e0d8.jpg"  width="324" height="720">

* 필수 등록정보 없이 등록하려 할 경우 예외처리

<img src="https://user-images.githubusercontent.com/79705809/109412811-71e56080-79ed-11eb-9255-d3da40620034.jpg"  width="324" height="720">

* 식물 등록이 완료되면 알림창과 함께 메인 페이지로 이동

<img src="https://user-images.githubusercontent.com/79705809/109412817-7d388c00-79ed-11eb-9050-e8383445768d.jpg"  width="324" height="720">

<img src="https://user-images.githubusercontent.com/79705809/109412818-80337c80-79ed-11eb-8c78-64620d4d70e0.jpg"  width="324" height="720">

---

## 3. 식물 관리 화면(목록)
* 등록된 식물의 리스트가 표시

<img src="https://user-images.githubusercontent.com/79705809/109412820-81fd4000-79ed-11eb-9e08-ae8ed8a54ee0.jpg"  width="324" height="720">

## 3. 식물 관리 화면(상세)
* 각각의 식물미다 관리할 수 있는 정보 표시

<img src="https://user-images.githubusercontent.com/79705809/109412823-83c70380-79ed-11eb-8976-8750611e4b38.jpg"  width="324" height="720">

* '물 주기' 버튼을 통해 식물 정보 업데이트(마지막 물 준 날짜, 예정 날짜, 남은 날짜)

<img src="https://user-images.githubusercontent.com/79705809/109412824-83c70380-79ed-11eb-8700-64f565ed42ac.jpg"  width="324" height="720">

<img src="https://user-images.githubusercontent.com/79705809/109412825-845f9a00-79ed-11eb-8220-afd5eaca600a.jpg"  width="324" height="720">

* '식물 삭제' 버튼을 통해 식물 삭제 가능

<img src="https://user-images.githubusercontent.com/79705809/109412826-845f9a00-79ed-11eb-9bb4-1865817d2042.jpg"  width="324" height="720">



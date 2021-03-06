# 프로젝트 소개

### 프로젝트 주제

유기동물(고양이) 보호센터 소개 사이트

개발기간 :  2020.12.28 ~ 2021. 01.25

------



### 개발도구 및 환경

- 운영체제 : MS Window10
- 서버 : Apache Tomcat 8.0
- DB : MySQL 5.7
- 개발 언어 : JAVA(JDK1.8), JSP, Javascript, HTML5, CSS3
- IDE : Eclipse
- API : Kakao Map, NaverSMTP, DAUM 우편번호검색

------



### 구현

###### 메인

- 드롭다운 메뉴 구성
- 스크립트를 사용한 이미지 자동 슬라이드 (수동 버튼 가능)
- 페이징 처리하여 최신글 보기 가능, 검색 기능
- ![main](https://user-images.githubusercontent.com/78060557/116646483-23375100-a9b3-11eb-8119-3f85bff9c9d0.png)

###### 회원

- 회원가입
  - 아이디와 닉네임 중복확인
  - 아이디, 비밀번호, 닉네임 정규표현식을 이용한 적합여부 판별
  - 기입한 이메일로 가입축하 메일 전송
  - 우편번호 검색 API 활용하여 주소 입력
  - ![join](https://user-images.githubusercontent.com/78060557/116646527-43671000-a9b3-11eb-90f9-de38c8ba618b.png)

- 마이페이지
  - 회원정보 수정 가능



###### 관리자

- 고양이 정보 등록, 수정, 삭제 가능
- 등록시 상태에 따라 보호중인 아이들 게시판이나 입양완료 게시판에 노출



###### 게시판

- 공지사항
  - 관리자 계정으로 접속하여 글 등록, 수정, 삭제 
  - 글 조회시 조회수 카운팅
  - 게시글 제목으로 검색 가능
  - 페이징 처리

- 위치
  - Kakao Map API 를 활용하여 주소 좌표에 마커를 띄워 지도에 표시
  - ![location](https://user-images.githubusercontent.com/78060557/116646521-3c400200-a9b3-11eb-859d-ae4fe1b3c469.png)

- 게시판 공통기능

  - 회원가입하여 로그인한 회원 글 등록 가능, 본인 글 수정과 삭제 가능

  - 페이징 처리

  - 게시글 제목으로 검색 가능

    

- 자원봉사

  - 관리자 계정으로 글 등록 가능. 등록시 파일 업로드 가능

  - 댓글 기능

    

- 문의합니다
  - 관리자 계정으로 게시글 답글 달기 


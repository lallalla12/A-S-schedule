# ❄️🔥 냉난방 AS기사 스케줄 관리 시스템

냉·난방 AS 업무를 효율적으로 처리하기 위해, **AS기사의 스케줄 및 방문 일정을 관리**할 수 있는 웹 기반 시스템입니다.  
일정 등록, 지도 기반 방문 위치 확인, 캘린더 UI를 활용한 편리한 관리 기능을 제공합니다.

---

## 🛠 사용 기술 스택

| 구분 | 기술 |
|------|------|
| Backend | Spring Framework, Spring MVC, MyBatis |
| Frontend | JSP, HTML, CSS, JavaScript, jQuery |
| DBMS | MySQL |
| UI 라이브러리 | FullCalendar.js, Bootstrap |
| 외부 API | Kakao 지도 API |
| 서버환경 | Apache Tomcat 9.x |
| IDE | STS (Spring Tool Suite 3) |

---

## ✨ 주요 기능

- 🗓️ **FullCalendar.js** 기반 스케줄 시각화
- 📍 **Kakao 지도 API**로 고객 주소 확인 및 경로 표시
- 👤 관리자 페이지에서 AS 기사별 스케줄 등록 및 수정
- 📋 고객별 요청 내역 확인 및 상태 변경 (처리중 → 완료 등)
- 🔔 팝업을 통한 기사 배정 기능
- 🔄 처리 상태에 따른 필터링 및 정렬 기능

---

## 📷 주요 화면 스크린샷

| 스케줄 캘린더 | 기사 배정 팝업 |
|---------------|----------------|
| ![calendar](screenshots/calendar.png) | ![popup](screenshots/popup.png) |


---

## 🚀 실행 방법

1. **프로젝트 다운로드**
   - Git으로 클론:  
     ```bash
     git clone https://github.com/your-username/as-schedule.git
     ```
   - 또는 ZIP 다운로드 후 압축 해제

2. **STS / Eclipse에서 Import**
   - `File` → `Import` → `Maven` → `Existing Maven Projects`
   - `pom.xml` 있는 폴더 선택 → `Finish`

3. **DB 연결 설정**
   - `context-datasource.xml` 또는 `application.properties` 파일에서
     본인의 MySQL 접속 정보(`url`, `username`, `password`)로 수정


4. **Tomcat 서버로 실행**
   - `Run on Server` → `Tomcat v9.0` 등 선택
   - 실행 후 접속:  
     ```
     http://localhost:8080/as-schedule
     ```

5. **기본 기능 페이지**
   - `/calendar` : 캘린더 스케줄
   - `/assign` : 기사 배정 팝업
   - `/map` : 고객 주소 지도 확인

> ⚠️ 실행 오류 시 Java, DB 연결 설정, Maven 빌드 상태를 확인하세요.

---

```markdown
## 🧩 시스템 플로우

[1] 사용자 A/S 신청
        ↓
[2] DB 저장 (Spring → MyBatis → MySQL)
        ↓
[3] 관리자 캘린더에서 할당 및 일정 확인
        ↓
[4] 기사님 사용자 시간과 주소로 배정
        ↓
[5] 처리 진행 상태로 변경
        ↓
[6] 기사님 방문 후 날짜 지정 
        ↓
[7] 처리 완료 상태로 변경






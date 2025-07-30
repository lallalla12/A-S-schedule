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

이 시스템은 관리자 중심의 냉·난방 A/S 업무를 효율적으로 처리하기 위한 기능들을 제공합니다.

### 📅 스케줄 관리
- **FullCalendar.js 기반**의 캘린더 UI를 통해 기사 스케줄을 한눈에 확인할 수 있습니다.
- 일간/주간/월간 단위로 전환 가능하며, 날짜 클릭 시 스케줄 등록 팝업이 뜹니다.

### 📍 위치 확인
- **Kakao 지도 API** 연동으로 고객 주소에 대한 정확한 위치를 확인할 수 있습니다.
- 기사 배정 시 고객 위치를 지도에서 미리 확인하고 방문 경로를 파악할 수 있습니다.

### 👤 기사 스케줄 등록/수정
- 관리자 페이지에서 각 AS 기사에 대해 방문일자와 고객 정보를 등록할 수 있습니다.
- 스케줄 클릭 시 수정 및 삭제 기능도 지원됩니다.

### 📋 고객 요청 상태 관리
- 고객별 A/S 요청 내역을 확인하고 상태를 다음과 같이 변경할 수 있습니다:  
  `요청 접수 → 처리중 → 방문 완료`
- 요청별 상세 정보와 접수 시간, 담당 기사, 상태 이력을 확인 가능합니다.

### 🔔 팝업 기반 기사 배정 기능
- 기사 선택 및 배정은 별도의 팝업 창에서 처리되며, 기사 리스트 및 근무 가능 여부 확인이 가능합니다.
- 배정이 완료되면 자동으로 캘린더에 반영됩니다.

### 🔄 상태별 필터 및 정렬
- 전체 스케줄에서 `처리중`, `완료`, `미배정` 등 상태별로 필터링하여 볼 수 있습니다.
- 기사 이름 또는 날짜 기준으로 정렬 기능도 제공합니다.
---

## 📷 주요 화면 스크린샷

| 스케줄 캘린더 | 기사 배정 팝업 |
|---------------|----------------|
| <img src="https://github.com/user-attachments/assets/0777ed1c-af12-42e1-aec5-58cb6a4b74dc" alt="스케줄 캘린더" width="400"/> | <img src="https://github.com/user-attachments/assets/5051e421-1bd5-453d-90d1-bb2695a72961" alt="기사 배정 팝업" width="400"/> |
| AS기사별 일정 확인 및 관리 | 팝업을 통한 기사 배정 및 상태 변경 |
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
## 🧩 시스템 플로우
```markdown
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
```
---
## 📷 시연 영상

<div align="center">

<video src="https://github.com/user-attachments/assets/26107459-42bd-451d-af97-2a4bc6e360b3" controls width="800"></video>

</div>









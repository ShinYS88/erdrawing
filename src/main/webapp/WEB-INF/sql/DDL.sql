/*
ERdrawing 테이블 정의서 (DDL) 
수정사항 있을 시 이곳에 바뀐 부분을 기입해주세요.
ex) member 테이블 memId 컬럼을 mem_Id로 변경
*/


/* 회원 */
CREATE TABLE MEMBER (
   MEM_ID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   MEMEMAIL VARCHAR2(100) NOT NULL, /* 이메일 */
   MEMPASS VARCHAR2(300) NOT NULL, /* 비밀번호 */
   MEMCANCEL_FLAG VARCHAR2(5) DEFAULT 'T' NOT NULL, /* 탈퇴여부 */
   MEMIMG VARCHAR2(300), /* 프로필이미지 */
   MEMAUTH VARCHAR2(5) DEFAULT 'T' NOT NULL, /* 관리자권한 */
   MEMNM VARCHAR2(100) NOT NULL, /* 이름 */
   MEMINTRO VARCHAR2(300), /* 자기소개 */
   MEMLANG VARCHAR2(10), /* 사용언어 */
   MEMTEL VARCHAR(11), /* 핸드폰번호 */
   MEMPERIOD DATE, /* 이용권기한 */
   MENINDT DATE, /* 회원가입날짜 */
   MEMBLACKFLAG VARCHAR2(5) /* 블랙리스트여부 */
);

COMMENT ON TABLE MEMBER IS '회원';

COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';

COMMENT ON COLUMN MEMBER.MEMEMAIL IS '이메일';

COMMENT ON COLUMN MEMBER.MEMPASS IS '비밀번호';

COMMENT ON COLUMN MEMBER.MEMCANCEL_FLAG IS '탈퇴여부';

COMMENT ON COLUMN MEMBER.MEMIMG IS '프로필이미지';

COMMENT ON COLUMN MEMBER.MEMAUTH IS '관리자권한';

COMMENT ON COLUMN MEMBER.MEMNM IS '이름';

COMMENT ON COLUMN MEMBER.MEMINTRO IS '자기소개';

COMMENT ON COLUMN MEMBER.MEMLANG IS '사용언어';

COMMENT ON COLUMN MEMBER.MEMTEL IS '핸드폰번호';

COMMENT ON COLUMN MEMBER.MEMPERIOD IS '이용권기한';

COMMENT ON COLUMN MEMBER.MENINDT IS '회원가입날짜';

COMMENT ON COLUMN MEMBER.MEMBLACKFLAG IS '블랙리스트여부';

CREATE UNIQUE INDEX PK_MEMBER
   ON MEMBER (
      MEM_ID ASC
   );

ALTER TABLE MEMBER
   ADD
      CONSTRAINT PK_MEMBER
      PRIMARY KEY (
         MEM_ID
      );

/* 팀 */
CREATE TABLE TEAM (
   TEAMNO NUMBER NOT NULL, /* 팀 번호 */
   TEAMNM VARCHAR2(100) NOT NULL, /* 팀 명 */
   TEAMINTRO VARCHAR2(300), /* 팀 소개 */
   TEAMIMG VARCHAR2(300), /* 썸네일이미지 */
   MAKERID VARCHAR2(100) NOT NULL /* 생성자 */
);

COMMENT ON TABLE TEAM IS '팀';

COMMENT ON COLUMN TEAM.TEAMNO IS '팀 번호';

COMMENT ON COLUMN TEAM.TEAMNM IS '팀 명';

COMMENT ON COLUMN TEAM.TEAMINTRO IS '팀 소개';

COMMENT ON COLUMN TEAM.TEAMIMG IS '썸네일이미지';

COMMENT ON COLUMN TEAM.MAKER_ID IS '생성자';

CREATE UNIQUE INDEX PK_TEAM
   ON TEAM (
      TEAMNO ASC
   );

ALTER TABLE TEAM
   ADD
      CONSTRAINT PK_TEAM
      PRIMARY KEY (
         TEAMNO
      );

/* 팀 내역 */
CREATE TABLE TEAM_LIST (
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   TEAMNO NUMBER NOT NULL, /* 팀 번호 */
   TEAMAUTH VARCHAR2(30), /* 권한 */
   TEAMAGREEFLAG VARCHAR2(5) /* 초대 수락유무 */
);

COMMENT ON TABLE TEAM_LIST IS '팀 내역';

COMMENT ON COLUMN TEAM_LIST.MEMID IS '회원아이디';

COMMENT ON COLUMN TEAM_LIST.TEAMNO IS '팀 번호';

COMMENT ON COLUMN TEAM_LIST.TEAMAUTH IS '권한';

COMMENT ON COLUMN TEAM_LIST.TEAMAGREFLAG IS '초대 수락유무';

CREATE UNIQUE INDEX PK_TEAM_LIST
   ON TEAM_LIST (
      MEMID ASC,
      TEAMNO ASC
   );

ALTER TABLE TEAM_LIST
   ADD
      CONSTRAINT PK_TEAM_LIST
      PRIMARY KEY (
         MEMID,
         TEAMNO
      );

/* 이용권 */
CREATE TABLE TICKET (
   TICKET_NO NUMBER NOT NULL, /* 이용권번호 */
   TICKETPRICE NUMBER NOT NULL, /* 이용권금액 */
   TICKETPERIOD DATE NOT NULL, /* 이용권기간 */
   TICKETIMG VARCHAR2(300), /* 이용권 이미지 경로 */
   TICKETCONTENT CLOB, /* 이용권 내용 */
   TICKETINDT DATE /* 이용권 등록일 */
);

COMMENT ON TABLE TICKET IS '이용권';

COMMENT ON COLUMN TICKET.TICKET_NO IS '이용권번호';

COMMENT ON COLUMN TICKET.TICKETPRICE IS '이용권금액';

COMMENT ON COLUMN TICKET.TICKETPERIOD IS '이용권기간';

COMMENT ON COLUMN TICKET.TICKETIMG IS '이용권 이미지 경로';

COMMENT ON COLUMN TICKET.TICKETCONTENT IS '이용권 내용';

COMMENT ON COLUMN TICKET.TICKETINDT IS '이용권 등록일';

CREATE UNIQUE INDEX PK_TICKET
   ON TICKET (
      TICKET_NO ASC
   );

ALTER TABLE TICKET
   ADD
      CONSTRAINT PK_TICKET
      PRIMARY KEY (
         TICKET_NO
      );

/* 이용권 구매내역 */
CREATE TABLE TICKET_BUY_HIST (
   TICKETBUYNO NUMBER NOT NULL, /* 이용권구매번호 */
   TICKETNO NUMBER NOT NULL, /* 이용권번호 */
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   TICKETBUYDT DATE, /* 이용권구매일 */
   TICKETFEE NUMBER /* 결제금액 */
);

COMMENT ON TABLE TICKET_BUY_HIST IS '이용권 구매내역';

COMMENT ON COLUMN TICKET_BUY_HIST.TICKETBUYNO IS '이용권구매번호';

COMMENT ON COLUMN TICKET_BUY_HIST.TICKETNO IS '이용권번호';

COMMENT ON COLUMN TICKET_BUY_HIST.MEMID IS '회원아이디';

COMMENT ON COLUMN TICKET_BUY_HIST.TICKETBUYDT IS '이용권구매일';

COMMENT ON COLUMN TICKET_BUY_HIST.TICKETFEE IS '결제금액';

CREATE UNIQUE INDEX PK_TICKET_BUY_HIST
   ON TICKET_BUY_HIST (
      TICKETBUYNO ASC
   );

ALTER TABLE TICKET_BUY_HIST
   ADD
      CONSTRAINT PK_TICKET_BUY_HIST
      PRIMARY KEY (
         TICKETBUYNO
      );

/* ERD */
CREATE TABLE ERD (
   ERDNO NUMBER NOT NULL, /* erd번호 */
   ERDTITLE VARCHAR2(100), /* 제목 */
   ERDSCOPE VARCHAR2(30), /* 공개범위(public/private/team) */
   ERDREADCNT NUMBER, /* 조회수 */
   ERDCDT DATE, /* 생성일 */
   ERDUDT DATE, /* 마지막수정일 */
   ERDCOLOR VARCHAR2(30), /* 배경색 */
   MEMID VARCHAR2(100), /* 회원아이디 */
   TEAMNO NUMBER /* 팀 번호 */
);

COMMENT ON TABLE ERD IS 'ERD';

COMMENT ON COLUMN ERD.ERDNO IS 'erd번호';

COMMENT ON COLUMN ERD.ERDTITLE IS '제목';

COMMENT ON COLUMN ERD.ERDSCOPE IS '공개범위(public/private/team)';

COMMENT ON COLUMN ERD.ERDREADCNT IS '조회수';

COMMENT ON COLUMN ERD.ERDCDT IS '생성일';

COMMENT ON COLUMN ERD.ERDUDT IS '마지막수정일';

COMMENT ON COLUMN ERD.ERDCOLOR IS '배경색';

COMMENT ON COLUMN ERD.MEMID IS '회원아이디';

COMMENT ON COLUMN ERD.TEAMNO IS '팀 번호';

CREATE UNIQUE INDEX PK_ERD
   ON ERD (
      ERDNO ASC
   );

ALTER TABLE ERD
   ADD
      CONSTRAINT PK_ERD
      PRIMARY KEY (
         ERDNO
      );

/* 엔터티 */
CREATE TABLE TABLES (
   TBNO NUMBER NOT NULL, /* 엔터티번호 */
   ENTITYNM VARCHAR2(50), /* 엔터티이름 */
   TBNM VARCHAR2(50), /* 테이블이름 */
   TBCOLOR VARCHAR2(30), /* 엔터티배경색 */
   TBX NUMBER, /* 엔터티X좌표 */
   TBY NUMBER, /* 엔터티Y좌표 */
   ERDNO NUMBER NOT NULL /* erd번호 */
);

COMMENT ON TABLE TABLES IS '엔터티';

COMMENT ON COLUMN TABLES.TBNO IS '엔터티번호';

COMMENT ON COLUMN TABLES.ENTITYNM IS '엔터티이름';

COMMENT ON COLUMN TABLES.TBNM IS '테이블이름';

COMMENT ON COLUMN TABLES.TBCOLOR IS '엔터티배경색';

COMMENT ON COLUMN TABLES.TBX IS '엔터티X좌표';

COMMENT ON COLUMN TABLES.TBY IS '엔터티Y좌표';

COMMENT ON COLUMN TABLES.ERDNO IS 'erd번호';

CREATE UNIQUE INDEX PK_TABLES
   ON TABLES (
      TBNO ASC
   );

ALTER TABLE TABLES
   ADD
      CONSTRAINT PK_TABLES
      PRIMARY KEY (
         TBNO
      );

/* 속성 */
CREATE TABLE COL (
   COLNO NUMBER NOT NULL, /* 속성번호 */
   ATTRNM VARCHAR2(50), /* 속성명 */
   COLNM VARCHAR2(50), /* 컬럼명 */
   COLDATATYPE VARCHAR2(50), /* 데이터타입 */
   COLDEFAULTVALUE VARCHAR2(100), /* Default value */
   COLISNULL VARCHAR2(10), /* 널 허용여부 */
   COLCOMMENT VARCHAR2(500), /* comment */
   COLORDER NUMBER, /* 속성순번 */
   TBNO NUMBER NOT NULL /* 엔터티번호 */
);

COMMENT ON TABLE COL IS '속성';

COMMENT ON COLUMN COL.COLUMNNO IS '속성번호';

COMMENT ON COLUMN COL.ATTRNM IS '속성명';

COMMENT ON COLUMN COL.COLNM IS '컬럼명';

COMMENT ON COLUMN COL.COLDATATYPE IS '데이터타입';

COMMENT ON COLUMN COL.COLDEFAULTVALUE IS 'Default value';

COMMENT ON COLUMN COL.COLISNULL IS '널 허용여부';

COMMENT ON COLUMN COL.COLCOMMENT IS 'comment';

COMMENT ON COLUMN COL.COLORDER IS '속성순번';

COMMENT ON COLUMN COL.TBNO IS '엔터티번호';

CREATE UNIQUE INDEX PK_COL
   ON COL (
      COLUMNNO ASC
   );

ALTER TABLE COL
   ADD
      CONSTRAINT PK_COL
      PRIMARY KEY (
         COLUMNNO
      );

/* 메모 */
CREATE TABLE MEMO (
   MEMONO NUMBER NOT NULL, /* 메모번호 */
   MEMOCONTENT VARCHAR2(500), /* 메모내용 */
   MEMOINDT DATE, /* 작성일 */
   MEMOX NUMBER, /* 메모X좌표 */
   MEMOY NUMBER, /* 메모Y좌표 */
   ERDHISTNO NUMBER NOT NULL /* erd번호 */
);

COMMENT ON TABLE MEMO IS '메모';

COMMENT ON COLUMN MEMO.MEMONO IS '메모번호';

COMMENT ON COLUMN MEMO.MEMOCONTENT IS '메모내용';

COMMENT ON COLUMN MEMO.MEMOINDT IS '작성일';

COMMENT ON COLUMN MEMO.MEMOX IS '메모X좌표';

COMMENT ON COLUMN MEMO.MENOY IS '메모Y좌표';

COMMENT ON COLUMN MEMO.ERDNO IS 'erd번호';

CREATE UNIQUE INDEX PK_MEMO
   ON MEMO (
      MEMONO ASC
   );

ALTER TABLE MEMO
   ADD
      CONSTRAINT PK_MEMO
      PRIMARY KEY (
         MEMONO
      );

/* 도메인 */
CREATE TABLE DOMAIN (
   DOMAINNO NUMBER NOT NULL, /* 도메인번호 */
   DOMAINNM VARCHAR(50) NOT NULL, /* 도메인이름 */
   DOMAINDATATYPE VARCHAR2(50), /* 데이터타입 */
   DOMAINDEFAULTVALUE VARCHAR2(100), /* Default value */
   ERDNO NUMBER NOT NULL /* erd번호 */
);

COMMENT ON TABLE DOMAIN IS '도메인';

COMMENT ON COLUMN DOMAIN.DOMAINNO IS '도메인번호';

COMMENT ON COLUMN DOMAIN.DOMAINNM IS '도메인이름';

COMMENT ON COLUMN DOMAIN.DOMAINDATATYPE IS '데이터타입';

COMMENT ON COLUMN DOMAIN.DOMAINDEFAULTVALUE IS 'Default value';

COMMENT ON COLUMN DOMAIN.ERDNO IS 'erd번호';

CREATE UNIQUE INDEX PK_DOMAIN
   ON DOMAIN (
      DOMAINNO ASC
   );

ALTER TABLE DOMAIN
   ADD
      CONSTRAINT PK_DOMAIN
      PRIMARY KEY (
         DOMAINNO
      );

/* 즐겨찾는ERD */
CREATE TABLE BOOKMARKERD (
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   ERDNO NUMBER NOT NULL, /* erd번호 */
   BMERDDT DATE /* 즐겨찾기한날짜 */
);

COMMENT ON TABLE BOOKMARKERD IS '즐겨찾는ERD';

COMMENT ON COLUMN BOOKMARKERD.MEMID IS '회원아이디';

COMMENT ON COLUMN BOOKMARKERD.ERDNO IS 'erd번호';

COMMENT ON COLUMN BOOKMARKERD.BMERDDT IS '즐겨찾기한날짜';

CREATE UNIQUE INDEX PK_BOOKMARKERD
   ON BOOKMARKERD (
      MEMID ASC,
      ERDNO ASC
   );

ALTER TABLE BOOKMARKERD
   ADD
      CONSTRAINT PK_BOOKMARKERD
      PRIMARY KEY (
         MEMID,
         ERDNO
      );

/* ERD내역 */
CREATE TABLE ERD_HIST (
   ERDHISTNO NUMBER NOT NULL, /* ERD내역번호 */
   ERDNO NUMBER NOT NULL, /* ERD번호 */
   ERDDT DATE, /* 생성날짜 */
   ERDISVISIBLE VARCHAR2(5), /* visibleT/F */
   SNAPNM VARCHAR2(50), /* 스냅샷명 */
   SNAPIMG VARCHAR2(300), /* 스냅샷이미지경로 */
   SNAPCDT DATE /* 스냅샷생성일자 */
);

COMMENT ON TABLE ERD_HIST IS 'ERD내역';

COMMENT ON COLUMN ERD_HIST.ERDHISTNO IS 'ERD내역번호';

COMMENT ON COLUMN ERD_HIST.ERDNO IS 'ERD번호';

COMMENT ON COLUMN ERD_HIST.ERDDT IS '생성날짜';

COMMENT ON COLUMN ERD_HIST.ERDISVISIBLE IS 'visibleT/F';

COMMENT ON COLUMN ERD_HIST.SNAPNM IS '스냅샷명';

COMMENT ON COLUMN ERD_HIST.SNAPIMG IS '스냅샷이미지경로';

COMMENT ON COLUMN ERD_HIST.SNAPCDT IS '스냅샷생성일자';

CREATE UNIQUE INDEX PK_ERD_HIST
   ON ERD_HIST (
      ERDHISTNO ASC
   );

ALTER TABLE ERD_HIST
   ADD
      CONSTRAINT PK_ERD_HIST
      PRIMARY KEY (
         ERDHISTNO
      );

/* 엔터티내역 */
CREATE TABLE TABLE_HIST (
   TBNO NUMBER NOT NULL, /* 엔터티내역번호 */
   ENTITYNM VARCHAR2(50), /* 엔터티이름 */
   TBNM VARCHAR2(50), /* 테이블이름 */
   TBCOLOR VARCHAR2(30), /* 엔터티배경색 */
   TBX NUMBER, /* 엔터티X좌표 */
   TBY NUMBER, /* 엔터티Y좌표 */
   ERDHISTNO NUMBER NOT NULL /* ERD내역번호 */
);

COMMENT ON TABLE TABLE_HIST IS '엔터티내역';

COMMENT ON COLUMN TABLE_HIST.TBNO IS '엔터티내역번호';

COMMENT ON COLUMN TABLE_HIST.ENTITYNM IS '엔터티이름';

COMMENT ON COLUMN TABLE_HIST.TBNM IS '테이블이름';

COMMENT ON COLUMN TABLE_HIST.TBCOLOR IS '엔터티배경색';

COMMENT ON COLUMN TABLE_HIST.TBX IS '엔터티X좌표';

COMMENT ON COLUMN TABLE_HIST.TBY IS '엔터티Y좌표';

COMMENT ON COLUMN TABLE_HIST.ERDHISTNO IS 'ERD내역번호';

CREATE UNIQUE INDEX PK_TABLE_HIST
   ON TABLE_HIST (
      TBNO ASC
   );

ALTER TABLE TABLE_HIST
   ADD
      CONSTRAINT PK_TABLE_HIST
      PRIMARY KEY (
         TBNO
      );

/* 속성내역 */
CREATE TABLE COL_HIST (
   COLNO NUMBER NOT NULL, /* 속성내역번호 */
   ATTRNM VARCHAR2(50), /* 속성명 */
   COLNM VARCHAR2(50), /* 컬럼명 */
   COLDATATYPE VARCHAR2(50), /* 데이터타입 */
   COLDEFAULTVALUE VARCHAR2(100), /* Default value */
   COLISNULL VARCHAR2(10), /* 널 허용여부 */
   COLCOMMENT VARCHAR2(500), /* comment */
   COLORDER NUMBER, /* 속성순번 */
   TBNO NUMBER NOT NULL /* 엔터티내역번호 */
);

COMMENT ON TABLE COL_HIST IS '속성내역';

COMMENT ON COLUMN COL_HIST.COLNO IS '속성내역번호';

COMMENT ON COLUMN COL_HIST.ATTRNM IS '속성명';

COMMENT ON COLUMN COL_HIST.COLNM IS '컬럼명';

COMMENT ON COLUMN COL_HIST.COLDATATYPE IS '데이터타입';

COMMENT ON COLUMN COL_HIST.COLDEFAULT_VALUE IS 'Default value';

COMMENT ON COLUMN COL_HIST.COLISNULL IS '널 허용여부';

COMMENT ON COLUMN COL_HIST.COLCOMMENT IS 'comment';

COMMENT ON COLUMN COL_HIST.COLORDER IS '속성순번';

COMMENT ON COLUMN COL_HIST.TBNO IS '엔터티내역번호';

CREATE UNIQUE INDEX PK_COL_HIST
   ON COL_HIST (
      COLNO ASC
   );

ALTER TABLE COL_HIST
   ADD
      CONSTRAINT PK_COL_HIST
      PRIMARY KEY (
         COLNO
      );

/* 메모내역 */
CREATE TABLE MEMO_HIST (
   MEMONO NUMBER NOT NULL, /* 메모내역번호 */
   MENOCONTENT VARCHAR2(500), /* 메모내용 */
   MEMOCDT DATE, /* 생성일 */
   MEMOX NUMBER, /* 메모X좌표 */
   MEMOY NUMBER, /* 메모Y좌표 */
   ERDNO NUMBER NOT NULL /* ERD내역번호 */
);

COMMENT ON TABLE MEMO_HIST IS '메모내역';

COMMENT ON COLUMN MEMO_HIST.MEMONO IS '메모내역번호';

COMMENT ON COLUMN MEMO_HIST.MENOHCONTENT IS '메모내용';

COMMENT ON COLUMN MEMO_HIST.MEMOHCDT IS '생성일';

COMMENT ON COLUMN MEMO_HIST.MEMOHX IS '메모X좌표';

COMMENT ON COLUMN MEMO_HIST.MEMOHY IS '메모Y좌표';

COMMENT ON COLUMN MEMO_HIST.ERDHNO IS 'ERD내역번호';

CREATE UNIQUE INDEX PK_MEMO_HIST
   ON MEMO_HIST (
      MEMONO ASC
   );

ALTER TABLE MEMO_HIST
   ADD
      CONSTRAINT PK_MEMO_HIST
      PRIMARY KEY (
         MEMONO
      );

/* 게시판 */
CREATE TABLE BOARD (
   BOARDNO NUMBER NOT NULL, /* 게시판번호 */
   BOARDNM VARCHAR2(50) NOT NULL /* 게시판이름 */
);

COMMENT ON TABLE BOARD IS '게시판';

COMMENT ON COLUMN BOARD.BOARDNO IS '게시판번호';

COMMENT ON COLUMN BOARD.BOARDNM IS '게시판이름';

CREATE UNIQUE INDEX PK_BOARD
   ON BOARD (
      BOARDNO ASC
   );

ALTER TABLE BOARD
   ADD
      CONSTRAINT PK_BOARD
      PRIMARY KEY (
         BOARDNO
      );

/* 게시글 */
CREATE TABLE POST (
   POSTNO NUMBER NOT NULL, /* 게시글번호 */
   POSTCONTENT CLOB, /* 게시글내용 */
   POSTREGDT DATE, /* 작성일시 */
   POSTGN NUMBER, /* 그룹번호 */
   POSTDELFLAG VARCHAR2(5), /* 삭제여부 */
   BOARDNO NUMBER, /* 게시판번호 */
   PARENTPOSTNO NUMBER, /* 부모게시글번호 */
   WriterId VARCHAR2(100) /* 작성자아이디 */
);

COMMENT ON TABLE POST IS '게시글';

COMMENT ON COLUMN POST.POSTNO IS '게시글번호';

COMMENT ON COLUMN POST.POSTCONTENT IS '게시글내용';

COMMENT ON COLUMN POST.POSTREGDT IS '작성일시';

COMMENT ON COLUMN POST.POSTGN IS '그룹번호';

COMMENT ON COLUMN POST.POSTDELFLAG IS '삭제여부';

COMMENT ON COLUMN POST.BOARDNO IS '게시판번호';

COMMENT ON COLUMN POST.PARENTPOSTNO IS '부모게시글번호';

COMMENT ON COLUMN POST.WriterId IS '작성자아이디';

CREATE UNIQUE INDEX PK_POST
   ON POST (
      POSTNO ASC
   );

ALTER TABLE POST
   ADD
      CONSTRAINT PK_POST
      PRIMARY KEY (
         POSTNO
      );

/* 댓글 */
CREATE TABLE COMMENTS (
   CMTNO NUMBER NOT NULL, /* 댓글번호 */
   CMTREGDT DATE, /* 댓글작성날짜 */
   CMTCONTENT VARCHAR2(1500), /* 댓글내용 */
   CMTDELFLAG VARCHAR2(5), /* 댓글 삭제여부 */
   POSTNO NUMBER NOT NULL, /* 게시글번호 */
   MEMID VARCHAR2(100) NOT NULL /* 댓글작성자아이디 */
);

COMMENT ON TABLE COMMENTS IS '댓글';

COMMENT ON COLUMN COMMENTS.CMTNO IS '댓글번호';

COMMENT ON COLUMN COMMENTS.CMTREGDT IS '댓글작성날짜';

COMMENT ON COLUMN COMMENTS.CMTCONTENT IS '댓글내용';

COMMENT ON COLUMN COMMENTS.CMTDELFLAG IS '댓글 삭제여부';

COMMENT ON COLUMN COMMENTS.POSTNO IS '게시글번호';

COMMENT ON COLUMN COMMENTS.MEMID IS '댓글작성자아이디';

CREATE UNIQUE INDEX PK_COMMENTS
   ON COMMENTS (
      CMTNO ASC
   );

ALTER TABLE COMMENTS
   ADD
      CONSTRAINT PK_COMMENTS
      PRIMARY KEY (
         CMTNO
      );

/* 첨부파일 */
CREATE TABLE UPLOADFILE (
   UPLOADFILENO NUMBER NOT NULL, /* 첨부파일번호 */
   POSTNO NUMBER NOT NULL, /* 게시글번호 */
   UPLOADFILENM VARCHAR2(50), /* 업로드파일명 */
   UPLOADREALFILEPATH VARCHAR2(300) /* 저장경로 */
);

COMMENT ON TABLE UPLOADFILE IS '첨부파일';

COMMENT ON COLUMN UPLOADFILE.UPLOADFILENO IS '첨부파일번호';

COMMENT ON COLUMN UPLOADFILE.POSTNO IS '게시글번호';

COMMENT ON COLUMN UPLOADFILE.UPLOADFILENAME IS '업로드파일명';

COMMENT ON COLUMN UPLOADFILE.UPLOADREALFILEPATH IS '저장경로';

CREATE UNIQUE INDEX PK_UPLOADFILE
   ON UPLOADFILE (
      UPLOADFILENO ASC
   );

ALTER TABLE UPLOADFILE
   ADD
      CONSTRAINT PK_UPLOADFILE
      PRIMARY KEY (
         UPLOADFILENO
      );

/* 채팅 */
CREATE TABLE CHAT (
   CHATNO NUMBER NOT NULL, /* 채팅번호 */
   ERDNO NUMBER NOT NULL, /* erd번호 */
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   CHATCONTENT VARCHAR2(1000), /* 채팅내용 */
   CHAINDT DATE /* 채팅작성날짜 */
);

COMMENT ON TABLE CHAT IS '채팅';

COMMENT ON COLUMN CHAT.CAHTNO IS '채팅번호';

COMMENT ON COLUMN CHAT.ERDNO IS 'erd번호';

COMMENT ON COLUMN CHAT.MEMID IS '회원아이디';

COMMENT ON COLUMN CHAT.CAHTCONTENT IS '채팅내용';

COMMENT ON COLUMN CHAT.CAHTINDT IS '채팅작성날짜';

CREATE UNIQUE INDEX PK_CHAT
   ON CHAT (
      CAHTNO ASC
   );

ALTER TABLE CHAT
   ADD
      CONSTRAINT PK_CHAT
      PRIMARY KEY (
         CAHTNO
      );

/* 쪽지 */
CREATE TABLE MESSAGE (
   MSGNO NUMBER NOT NULL, /* 쪽지번호 */
   SENDER_ID VARCHAR2(100) NOT NULL, /* 송신회원아이디 */
   SENDDT DATE, /* 보낸날짜 */
   MSGTITLE VARCHAR2(300), /* 제목 */
   MSGCONTENT VARCHAR2(500), /* 내용 */
   MSGTYPE VARCHAR2(5) /* 쪽지구분 */
);

COMMENT ON TABLE MESSAGE IS '쪽지';

COMMENT ON COLUMN MESSAGE.MSGNO IS '쪽지번호';

COMMENT ON COLUMN MESSAGE.SENDER_ID IS '송신회원아이디';

COMMENT ON COLUMN MESSAGE.SENDDATE IS '보낸날짜';

COMMENT ON COLUMN MESSAGE.MSGTITLE IS '제목';

COMMENT ON COLUMN MESSAGE.MSGCONTENT IS '내용';

COMMENT ON COLUMN MESSAGE.MSGTYPE IS '쪽지구분';

CREATE UNIQUE INDEX PK_MESSAGE
   ON MESSAGE (
      MSGNO ASC
   );

ALTER TABLE MESSAGE
   ADD
      CONSTRAINT PK_MESSAGE
      PRIMARY KEY (
         MSGNO
      );

/* 디스플레이 */
CREATE TABLE DISPLAY (
   DISPNO NUMBER NOT NULL, /* 디스플레이 번호 */
   DISPTYPE VARCHAR2(30) NOT NULL, /* 디스플레이 구분 */
   ERDNO NUMBER NOT NULL /* erd번호 */
);

COMMENT ON TABLE DISPLAY IS '디스플레이';

COMMENT ON COLUMN DISPLAY.DISPNO IS '디스플레이 번호';

COMMENT ON COLUMN DISPLAY.DISPTYPE IS '디스플레이 구분';

COMMENT ON COLUMN DISPLAY.ERDNO IS 'erd번호';

CREATE UNIQUE INDEX PK_DISPLAY
   ON DISPLAY (
      DISPNO ASC
   );

ALTER TABLE DISPLAY
   ADD
      CONSTRAINT PK_DISPLAY
      PRIMARY KEY (
         DISPNO
      );

/* ERD_좋아요 */
CREATE TABLE ERD_LIKE (
   ERDNO NUMBER NOT NULL, /* erd번호 */
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   ERDLIKEDT DATE /* 좋아요를 누른 날짜 */
);

COMMENT ON TABLE ERD_LIKE IS 'ERD_좋아요';

COMMENT ON COLUMN ERD_LIKE.ERDNO IS 'erd번호';

COMMENT ON COLUMN ERD_LIKE.MEMID IS '회원아이디';

COMMENT ON COLUMN ERD_LIKE.ERDLIKEDT IS '좋아요를 누른 날짜';

CREATE UNIQUE INDEX PK_ERD_LIKE
   ON ERD_LIKE (
      ERDNO ASC,
      MEMID ASC
   );

ALTER TABLE ERD_LIKE
   ADD
      CONSTRAINT PK_ERD_LIKE
      PRIMARY KEY (
         ERDNO,
         MEMID
      );

/* 댓글좋아요 */
CREATE TABLE COMMENT_LIKE (
   CMTNO NUMBER NOT NULL, /* 댓글번호 */
   MEMID VARCHAR2(100) NOT NULL, /* 회원아이디 */
   CMTLIKEDT DATE /* 좋아요를 누른날짜 */
);

COMMENT ON TABLE COMMENT_LIKE IS '댓글좋아요';

COMMENT ON COLUMN COMMENT_LIKE.CMTNO IS '댓글번호';

COMMENT ON COLUMN COMMENT_LIKE.MEMID IS '회원아이디';

COMMENT ON COLUMN COMMENT_LIKE.COMMENTLIKEDT IS '좋아요를 누른날짜';

CREATE UNIQUE INDEX PK_COMMENT_LIKE
   ON COMMENT_LIKE (
      CMTNO ASC,
      MEMID ASC
   );

ALTER TABLE COMMENT_LIKE
   ADD
      CONSTRAINT PK_COMMENT_LIKE
      PRIMARY KEY (
         CMTNO,
         MEMID
      );

/* 이용권환불내역 */
CREATE TABLE TICKET_REF_HIST (
   TICKETBUYNO NUMBER NOT NULL, /* 이용권구매번호 */
   REFUNDREQDT DATE, /* 환불신청날짜 */
   ACCOUNT VARCHAR2(30) NOT NULL, /* 계좌번호 */
   BANKNM VARCHAR2(30) NOT NULL, /* 은행명 */
   ACCOUNTHOLDER VARCHAR2(30) NOT NULL, /* 예금주명 */
   REFUND_RESPDT DATE /* 환불날짜 */
);

COMMENT ON TABLE TICKET_REF_HIST IS '이용권환불내역';

COMMENT ON COLUMN TICKET_REF_HIST.TICKETBUYNO IS '이용권구매번호';

COMMENT ON COLUMN TICKET_REF_HIST.REFINDREQDT IS '환불신청날짜';

COMMENT ON COLUMN TICKET_REF_HIST.ACCOUNT IS '계좌번호';

COMMENT ON COLUMN TICKET_REF_HIST.BANKNM IS '은행명';

COMMENT ON COLUMN TICKET_REF_HIST.ACCOUNTHOLDER IS '예금주명';

COMMENT ON COLUMN TICKET_REF_HIST.REFUND_RESPDT IS '환불날짜';

CREATE UNIQUE INDEX PK_TICKET_REF_HIST
   ON TICKET_REF_HIST (
      TICKETBUYNO ASC
   );

ALTER TABLE TICKET_REF_HIST
   ADD
      CONSTRAINT PK_TICKET_REF_HIST
      PRIMARY KEY (
         TICKETBUYNO
      );

/* 신고 */
CREATE TABLE REPORT (
   FROMMEMID VARCHAR2(100) NOT NULL, /* 신고한회원아이디 */
   TOMEMID VARCHAR2(100) NOT NULL, /* 신고당한회원 */
   REPORTREASON VARCHAR2(300), /* 신고사유 */
   REPORTDT DATE /* 신고날짜 */
);

COMMENT ON TABLE REPORT IS '신고';

COMMENT ON COLUMN REPORT.FROMMEMID IS '신고한회원아이디';

COMMENT ON COLUMN REPORT.TOMEMID IS '신고당한회원';

COMMENT ON COLUMN REPORT.REPORTREASON IS '신고사유';

COMMENT ON COLUMN REPORT.REPORTDT IS '신고날짜';

CREATE UNIQUE INDEX PK_REPORT
   ON REPORT (
      FROMMEMID ASC,
      TOMEMID ASC
   );

ALTER TABLE REPORT
   ADD
      CONSTRAINT PK_REPORT
      PRIMARY KEY (
         FROMMEMID,
         TOMEMID
      );

/* 수신자 */
CREATE TABLE MESSAGE_RECEIVER (
   MSGNO NUMBER NOT NULL, /* 쪽지번호 */
   RECIEVERID VARCHAR2(100) NOT NULL, /* 수신회원아이디 */
   RECEIVEFLAG VARCHAR2(5), /* 수신여부 */
   DELFLAG VARCHAR2(5) /* 삭제여부 */
);

COMMENT ON TABLE MESSAGE_RECEIVER IS '수신자';

COMMENT ON COLUMN MESSAGE_RECEIVER.MSGNO IS '쪽지번호';

COMMENT ON COLUMN MESSAGE_RECEIVER.RECIEVERID IS '수신회원아이디';

COMMENT ON COLUMN MESSAGE_RECEIVER.RECEIVEFLAG IS '수신여부';

COMMENT ON COLUMN MESSAGE_RECEIVER.DELFLAG IS '삭제여부';

CREATE UNIQUE INDEX PK_MESSAGE_RECEIVER
   ON MESSAGE_RECEIVER (
      MSGNO ASC,
      RECIEVERID ASC
   );

ALTER TABLE MESSAGE_RECEIVER
   ADD
      CONSTRAINT PK_MESSAGE_RECEIVER
      PRIMARY KEY (
         MSGNO,
         RECIEVERID
      );

/* 태그내역 */
CREATE TABLE TAG_HIST (
   ERDNO NUMBER NOT NULL, /* erd번호 */
   TAGNO NUMBER NOT NULL, /* 태그번호 */
   TAGDT DATE /* 태그내역등록날짜 */
);

COMMENT ON TABLE TAG_HIST IS '태그내역';

COMMENT ON COLUMN TAG_HIST.ERDNO IS 'erd번호';

COMMENT ON COLUMN TAG_HIST.TAGNO IS '태그번호';

COMMENT ON COLUMN TAG_HIST.TAGDT IS '태그내역등록날짜';

CREATE UNIQUE INDEX PK_TAG_HIST
   ON TAG_HIST (
      ERDNO ASC,
      TAGNO ASC
   );

ALTER TABLE TAG_HIST
   ADD
      CONSTRAINT PK_TAG_HIST
      PRIMARY KEY (
         ERDNO,
         TAGNO
      );

/* 태그 */
CREATE TABLE TAG (
   TAGNO NUMBER NOT NULL, /* 태그번호 */
   TAGCONTENT VARCHAR2(50) NOT NULL, /* 태그내용 */
   TAGINDT DATE, /* 태그등록일시 */
   TAGMAKER VARCHAR2(100) /* 태그작성자 */
);

COMMENT ON TABLE TAG IS '태그';

COMMENT ON COLUMN TAG.TAGNO IS '태그번호';

COMMENT ON COLUMN TAG.TAGCONTENT IS '태그내용';

COMMENT ON COLUMN TAG.TAGINDT IS '태그등록일시';

COMMENT ON COLUMN TAG.TAGMAKER IS '태그작성자';

CREATE UNIQUE INDEX PK_TAG
   ON TAG (
      TAGNO ASC
   );

ALTER TABLE TAG
   ADD
      CONSTRAINT PK_TAG
      PRIMARY KEY (
         TAGNO
      );

/* 제약조건 */
CREATE TABLE CONSTR (
   CONSTRNO NUMBER NOT NULL, /* 제약조건번호 */
   CONSTRNM VARCHAR2(50), /* 제약조건명 */
   CONSTRTYPE VARCHAR2(5), /* 제약조건구분 */
   TBNO NUMBER /* 엔터티번호 */
);

COMMENT ON TABLE CONSTR IS '제약조건';

COMMENT ON COLUMN CONSTR.CONSTRNO IS '제약조건번호';

COMMENT ON COLUMN CONSTR.CONSTRNM IS '제약조건명';

COMMENT ON COLUMN CONSTR.CONSTRTYPE IS '제약조건구분';

COMMENT ON COLUMN CONSTR.TBNO IS '엔터티번호';

CREATE UNIQUE INDEX PK_CONSTR
   ON CONSTR (
      CONSTRNO ASC
   );

ALTER TABLE CONSTR
   ADD
      CONSTRAINT PK_CONSTR
      PRIMARY KEY (
         CONSTRNO
      );

/* FK_제약조건 */
CREATE TABLE FK_CONSTR (
   CONSTRNO NUMBER NOT NULL, /* 제약조건번호 */
   FKRELATIONTYPE VARCHAR2(10), /* 관계종류(1:1,1:N) */
   REFERPKCONSTRNO NUMBER NOT NULL /* 참조PK제약조건번호 */
);

COMMENT ON TABLE FK_CONSTR IS 'FK_제약조건';

COMMENT ON COLUMN FK_CONSTR.CONSTRNO IS '제약조건번호';

COMMENT ON COLUMN FK_CONSTR.FKRELATIONTYPE IS '관계종류(1:1,1:N)';

COMMENT ON COLUMN FK_CONSTR.FKCONSTRPKNO IS '참조PK제약조건번호';

CREATE UNIQUE INDEX PK_FK_CONSTR
   ON FK_CONSTR (
      CONSTRNO ASC
   );

ALTER TABLE FK_CONSTR
   ADD
      CONSTRAINT PK_FK_CONSTR
      PRIMARY KEY (
         CONSTRNO
      );

/* FK_제약조건내역 */
CREATE TABLE FK_CONSTR_HIST (
   CONSTRNO NUMBER NOT NULL, /* 제약조건내역번호 */
   FKRELATIONTYPE VARCHAR2(10), /* FK_제약조건종류(1:1,1:N) */
   REFERPKCONSTRNO NUMBER NOT NULL /* Fk_참조PK제약조건번호 */
);

COMMENT ON TABLE FK_CONSTR_HIST IS 'FK_제약조건내역';

COMMENT ON COLUMN FK_CONSTR_HIST.CONSTRNO IS '제약조건내역번호';

COMMENT ON COLUMN FK_CONSTR_HIST.FKRELATIONTYPE IS 'FK_제약조건종류(1:1,1:N)';

COMMENT ON COLUMN FK_CONSTR_HIST.FKREFERPKCONSTRNO IS 'Fk_참조PK제약조건번호';

CREATE UNIQUE INDEX PK_FK_CONSTR_HIST
   ON FK_CONSTR_HIST (
      CONSTRNO ASC
   );

ALTER TABLE FK_CONSTR_HIST
   ADD
      CONSTRAINT PK_FK_CONSTR_HIST
      PRIMARY KEY (
         CONSTRNO
      );

/* 제약조건내역 */
CREATE TABLE CONSTR_HIST (
   CONSTRNO NUMBER NOT NULL, /* 제약조건내역번호 */
   CONSTRNM VARCHAR2(50), /* 제약조건내역명 */
   CONSTRTYPE VARCHAR2(5), /* 제약조건내역구분 */
   TBNO NUMBER /* 엔터티내역번호 */
);

COMMENT ON TABLE CONSTR_HIST IS '제약조건내역';

COMMENT ON COLUMN CONSTR_HIST.CONSTRNO IS '제약조건내역번호';

COMMENT ON COLUMN CONSTR_HIST.CONSTRNM IS '제약조건내역명';

COMMENT ON COLUMN CONSTR_HIST.CONSTRTYPE IS '제약조건내역구분';

COMMENT ON COLUMN CONSTR_HIST.TBNO IS '엔터티내역번호';

CREATE UNIQUE INDEX PK_CONSTR_HIST
   ON CONSTR_HIST (
      CONSTRNO ASC
   );

ALTER TABLE CONSTR_HIST
   ADD
      CONSTRAINT PK_CONSTR_HIST
      PRIMARY KEY (
         CONSTRNO
      );

/* 제약조건속성 */
CREATE TABLE CONSTR_COL (
   CONSTRNO NUMBER NOT NULL, /* 제약조건번호 */
   COLNO NUMBER NOT NULL, /* 속성번호 */
   CONSTRCOLORDER NUMBER /* 제약조건속성순번 */
);

COMMENT ON TABLE CONSTR_COL IS '제약조건속성';

COMMENT ON COLUMN CONSTR_COL.CONSTRNO IS '제약조건번호';

COMMENT ON COLUMN CONSTR_COL.COLUMNNO IS '속성번호';

COMMENT ON COLUMN CONSTR_COL.CONSTRCOLORDER IS '제약조건속성순번';

CREATE UNIQUE INDEX PK_CONSTR_COL
   ON CONSTR_COL (
      CONSTRNO ASC,
      COLUMNNO ASC
   );

ALTER TABLE CONSTR_COL
   ADD
      CONSTRAINT PK_CONSTR_COL
      PRIMARY KEY (
         CONSTRNO,
         COLUMNNO
      );

/* 제약조건속성내역 */
CREATE TABLE CONSTR_COL_HIST (
   CONSTRNO NUMBER NOT NULL, /* 제약조건내역번호 */
   COLNO NUMBER NOT NULL, /* 속성내역번호 */
   CONSTRCOLORDER NUMBER /* 제약조건속성내역순번 */
);

COMMENT ON TABLE CONSTR_COL_HIST IS '제약조건속성내역';

COMMENT ON COLUMN CONSTR_COL_HIST.CONSTRNO IS '제약조건내역번호';

COMMENT ON COLUMN CONSTR_COL_HIST.COLNO IS '속성내역번호';

COMMENT ON COLUMN CONSTR_COL_HIST.CONSTRCOLORDER IS '제약조건속성내역순번';

CREATE UNIQUE INDEX PK_CONSTR_COL_HIST
   ON CONSTR_COL_HIST (
      CONSTRNO ASC,
      COLNO ASC
   );

ALTER TABLE CONSTR_COL_HIST
   ADD
      CONSTRAINT PK_CONSTR_COL_HIST
      PRIMARY KEY (
         CONSTRNO,
         COLNO
      );

ALTER TABLE TEAM
   ADD
      CONSTRAINT FK_MEMBER_TO_TEAM
      FOREIGN KEY (
         MAKER_ID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE TEAM_LIST
   ADD
      CONSTRAINT FK_TEAM_TO_TEAM_LIST
      FOREIGN KEY (
         TEAMNO
      )
      REFERENCES TEAM (
         TEAMNO
      );

ALTER TABLE TEAM_LIST
   ADD
      CONSTRAINT FK_MEMBER_TO_TEAM_LIST
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE TICKET_BUY_HIST
   ADD
      CONSTRAINT FK_TICKET_TO_TICKET_BUY_HIST
      FOREIGN KEY (
         TICKETNO
      )
      REFERENCES TICKET (
         TICKET_NO
      );

ALTER TABLE TICKET_BUY_HIST
   ADD
      CONSTRAINT FK_MEMBER_TO_TICKET_BUY_HIST
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE ERD
   ADD
      CONSTRAINT FK_MEMBER_TO_ERD
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE ERD
   ADD
      CONSTRAINT FK_TEAM_TO_ERD
      FOREIGN KEY (
         TEAMNO
      )
      REFERENCES TEAM (
         TEAMNO
      );

ALTER TABLE TABLES
   ADD
      CONSTRAINT FK_ERD_TO_TABLES
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE COL
   ADD
      CONSTRAINT FK_TABLES_TO_COL
      FOREIGN KEY (
         TBNO
      )
      REFERENCES TABLES (
         TBNO
      );

ALTER TABLE MEMO
   ADD
      CONSTRAINT FK_ERD_TO_MEMO
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE DOMAIN
   ADD
      CONSTRAINT FK_ERD_TO_DOMAIN
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE BOOKMARKERD
   ADD
      CONSTRAINT FK_MEMBER_TO_BOOKMARKERD
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE BOOKMARKERD
   ADD
      CONSTRAINT FK_ERD_TO_BOOKMARKERD
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE ERD_HIST
   ADD
      CONSTRAINT FK_ERD_TO_ERD_HIST
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE TABLE_HIST
   ADD
      CONSTRAINT FK_ERD_HIST_TO_TABLE_HIST
      FOREIGN KEY (
         ERDHISTNO
      )
      REFERENCES ERD_HIST (
         ERDHISTNO
      );

ALTER TABLE COL_HIST
   ADD
      CONSTRAINT FK_TABLE_HIST_TO_COL_HIST
      FOREIGN KEY (
         TBNO
      )
      REFERENCES TABLE_HIST (
         TBNO
      );

ALTER TABLE MEMO_HIST
   ADD
      CONSTRAINT FK_ERD_HIST_TO_MEMO_HIST
      FOREIGN KEY (
         ERDHNO
      )
      REFERENCES ERD_HIST (
         ERDHISTNO
      );

ALTER TABLE POST
   ADD
      CONSTRAINT FK_BOARD_TO_POST
      FOREIGN KEY (
         BOARDNO
      )
      REFERENCES BOARD (
         BOARDNO
      );

ALTER TABLE POST
   ADD
      CONSTRAINT FK_POST_TO_POST
      FOREIGN KEY (
         PARENTPOSTNO
      )
      REFERENCES POST (
         POSTNO
      );

ALTER TABLE POST
   ADD
      CONSTRAINT FK_MEMBER_TO_POST
      FOREIGN KEY (
         WriterId
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE COMMENTS
   ADD
      CONSTRAINT FK_POST_TO_COMMENTS
      FOREIGN KEY (
         POSTNO
      )
      REFERENCES POST (
         POSTNO
      );

ALTER TABLE COMMENTS
   ADD
      CONSTRAINT FK_MEMBER_TO_COMMENTS
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE UPLOADFILE
   ADD
      CONSTRAINT FK_POST_TO_UPLOADFILE
      FOREIGN KEY (
         POSTNO
      )
      REFERENCES POST (
         POSTNO
      );

ALTER TABLE CHAT
   ADD
      CONSTRAINT FK_ERD_TO_CHAT
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE CHAT
   ADD
      CONSTRAINT FK_MEMBER_TO_CHAT
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE MESSAGE
   ADD
      CONSTRAINT FK_MEMBER_TO_MESSAGE
      FOREIGN KEY (
         SENDER_ID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE DISPLAY
   ADD
      CONSTRAINT FK_ERD_TO_DISPLAY
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE ERD_LIKE
   ADD
      CONSTRAINT FK_ERD_TO_ERD_LIKE
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE ERD_LIKE
   ADD
      CONSTRAINT FK_MEMBER_TO_ERD_LIKE
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE COMMENT_LIKE
   ADD
      CONSTRAINT FK_COMMENTS_TO_COMMENT_LIKE
      FOREIGN KEY (
         CMTNO
      )
      REFERENCES COMMENTS (
         CMTNO
      );

ALTER TABLE COMMENT_LIKE
   ADD
      CONSTRAINT FK_MEMBER_TO_COMMENT_LIKE
      FOREIGN KEY (
         MEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE TICKET_REF_HIST
   ADD
      CONSTRAINT FK_TICK_BUY_H_TO_TICK_REF_H
      FOREIGN KEY (
         TICKETBUYNO
      )
      REFERENCES TICKET_BUY_HIST (
         TICKETBUYNO
      );

ALTER TABLE REPORT
   ADD
      CONSTRAINT FK_MEMBER_TO_REPORT2
      FOREIGN KEY (
         FROMMEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE REPORT
   ADD
      CONSTRAINT FK_MEMBER_TO_REPORT
      FOREIGN KEY (
         TOMEMID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE MESSAGE_RECEIVER
   ADD
      CONSTRAINT FK_MESSAGE_TO_MESSAGE_RECEIVER
      FOREIGN KEY (
         MSGNO
      )
      REFERENCES MESSAGE (
         MSGNO
      );

ALTER TABLE MESSAGE_RECEIVER
   ADD
      CONSTRAINT FK_MEMBER_TO_MESSAGE_RECEIVER
      FOREIGN KEY (
         RECIEVERID
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE TAG_HIST
   ADD
      CONSTRAINT FK_TAG_TO_TAG_HIST
      FOREIGN KEY (
         TAGNO
      )
      REFERENCES TAG (
         TAGNO
      );

ALTER TABLE TAG_HIST
   ADD
      CONSTRAINT FK_ERD_TO_TAG_HIST
      FOREIGN KEY (
         ERDNO
      )
      REFERENCES ERD (
         ERDNO
      );

ALTER TABLE TAG
   ADD
      CONSTRAINT FK_MEMBER_TO_TAG
      FOREIGN KEY (
         TAGMAKER
      )
      REFERENCES MEMBER (
         MEM_ID
      );

ALTER TABLE CONSTR
   ADD
      CONSTRAINT FK_TABLES_TO_CONSTR
      FOREIGN KEY (
         TBNO
      )
      REFERENCES TABLES (
         TBNO
      );

ALTER TABLE FK_CONSTR
   ADD
      CONSTRAINT FK_CONSTR_TO_FK_CONSTR
      FOREIGN KEY (
         CONSTRNO
      )
      REFERENCES CONSTR (
         CONSTRNO
      );

ALTER TABLE FK_CONSTR
   ADD
      CONSTRAINT FK_CONSTR_TO_FK_CONSTR2
      FOREIGN KEY (
         FKCONSTRPKNO
      )
      REFERENCES CONSTR (
         CONSTRNO
      );

ALTER TABLE FK_CONSTR_HIST
   ADD
      CONSTRAINT FK_CONSTR_H_TO_FK_CONSTR_H
      FOREIGN KEY (
         CONSTRNO
      )
      REFERENCES CONSTR_HIST (
         CONSTRNO
      );

ALTER TABLE FK_CONSTR_HIST
   ADD
      CONSTRAINT FK_CONSTR_H_TO_FK_CONSTR_H2
      FOREIGN KEY (
         FKREFERPKCONSTRNO
      )
      REFERENCES CONSTR_HIST (
         CONSTRNO
      );

ALTER TABLE CONSTR_HIST
   ADD
      CONSTRAINT FK_TABLE_HIST_TO_CONSTR_HIST
      FOREIGN KEY (
         TBNO
      )
      REFERENCES TABLE_HIST (
         TBNO
      );

ALTER TABLE CONSTR_COL
   ADD
      CONSTRAINT FK_CONSTR_TO_CONSTR_COL
      FOREIGN KEY (
         CONSTRNO
      )
      REFERENCES CONSTR (
         CONSTRNO
      );

ALTER TABLE CONSTR_COL
   ADD
      CONSTRAINT FK_COL_TO_CONSTR_COL
      FOREIGN KEY (
         COLUMNNO
      )
      REFERENCES COL (
         COLUMNNO
      );

ALTER TABLE CONSTR_COL_HIST
   ADD
      CONSTRAINT FK_COL_HIST_TO_CONSTR_COL_HIST
      FOREIGN KEY (
         COLNO
      )
      REFERENCES COL_HIST (
         COLNO
      );

ALTER TABLE CONSTR_COL_HIST
   ADD
      CONSTRAINT FK_CONSTR_H_TO_CONSTR_COL_H
      FOREIGN KEY (
         CONSTRNO
      )
      REFERENCES CONSTR_HIST (
         CONSTRNO
      );



    ---------------------------------------------------------------------
  CREATE SEQUENCE seq_BOARDNO
     start with 1000
   INCREMENT BY 1;
    
    
    
  CREATE SEQUENCE seq_CHATNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_COLNO
     start with 1000
   INCREMENT BY 1;
    

    
  CREATE SEQUENCE seq_COL_H_NO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_CMTNO
     start with 1000
   INCREMENT BY 1;
    
      
  CREATE SEQUENCE seq_CONSTRNO
     start with 1000
   INCREMENT BY 1;

    
  CREATE SEQUENCE seq_CONSTR_H_NO
     start with 1000
   INCREMENT BY 1;
    
       
  CREATE SEQUENCE seq_DISPNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_DOMAINNO
     start with 1000
   INCREMENT BY 1;

    CREATE SEQUENCE seq_ERDNO
     start with 1000
   INCREMENT BY 1;
    
    CREATE SEQUENCE seq_ERDHISTNO
     start with 1000
   INCREMENT BY 1;
    
     
    
    CREATE SEQUENCE seq_MEMONO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_MEMO_H_NO
     start with 1000
   INCREMENT BY 1;
    
       
  CREATE SEQUENCE seq_MSGNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_POSTNO
     start with 1000
   INCREMENT BY 1;
       -----------
    
  CREATE SEQUENCE seq_TB_H_NO
     start with 1000
   INCREMENT BY 1;
    
  CREATE SEQUENCE seq_TBNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TAGNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TEAMNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TICKET_NO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TICKETBUYNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_UPLOADFILENO
     start with 1000
   INCREMENT BY 1;

        
  CREATE SEQUENCE seq_BOARDNO
     start with 1000
   INCREMENT BY 1;
    
    
    
  CREATE SEQUENCE seq_CHATNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_COLNO
     start with 1000
   INCREMENT BY 1;
    

    
  CREATE SEQUENCE seq_COL_H_NO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_CMTNO
     start with 1000
   INCREMENT BY 1;
    
      
  CREATE SEQUENCE seq_CONSTRNO
     start with 1000
   INCREMENT BY 1;

    
  CREATE SEQUENCE seq_CONSTR_H_NO
     start with 1000
   INCREMENT BY 1;
    
       
  CREATE SEQUENCE seq_DISPNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_DOMAINNO
     start with 1000
   INCREMENT BY 1;

    CREATE SEQUENCE seq_ERDNO
     start with 1000
   INCREMENT BY 1;
    
    CREATE SEQUENCE seq_ERDHISTNO
     start with 1000
   INCREMENT BY 1;
    
     
    
    CREATE SEQUENCE seq_MEMONO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_MEMO_H_NO
     start with 1000
   INCREMENT BY 1;
    
       
  CREATE SEQUENCE seq_MSGNO
     start with 1000
   INCREMENT BY 1;
    
    
  CREATE SEQUENCE seq_POSTNO
     start with 1000
   INCREMENT BY 1;
       -----------
    
  CREATE SEQUENCE seq_TB_H_NO
     start with 1000
   INCREMENT BY 1;
    
  CREATE SEQUENCE seq_TBNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TAGNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TEAMNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TICKET_NO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_TICKETBUYNO
     start with 1000
   INCREMENT BY 1;
    
    
      CREATE SEQUENCE seq_UPLOADFILENO
     start with 1000
   INCREMENT BY 1;



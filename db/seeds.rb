# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

challenge01 = Challenge.create(:title => 'Feed Test',
                      :goal => 'Spring을 활용한 다양한 기능 완성하기',
                      :information => '로그인 기능
  •/login에서 Login.html을 호출
  •/login에서 아이디와 비밀번호를 입력 후 일치할 경우 /feed로 이동
    ※입력한 아이디가 없는 경우 ErrorPage.html 호출
    ※비밀번호가 틀린 없는 경우 ErrorPage.html 호출
    ※해당 아이디가 로그인 중(isEnable=false)인 경우
    ErrorPage.html 호출

가입 기능
  •/login의 가입하기를 누를 시 /join으로 이동
  •/join에서 Join.html을 호출
  •/join에서 아이디와 패스워드를 입력하고 가입하기를 누를 시
    DB에 아이디와 패스워드가 저장
    ※중복 아이디일 경우 ErrorPage.html 호출

게시물 기능
  •/feed에서 Feed.html 호출
  •/feed에서 왼쪽 상단 개인정보에 로그인한 사람의 아이디, 게시물 수,
  팔로워 수, 팔로윙 수가 반영되도록 작성
  •/feed에서 로그아웃 클릭 시 /login으로 이동
  •/feed에서 우측에 작성된 모든 글이 보이도록 작성
  •/{로그인한 ID}에서 자신과 팔로우 한 사람의 글이 보이도록 작성
  •/{다른 사람 ID}에서는 그 사람이 작성한 글만 보이도록 작성

게시물 기능
  •/feed에서 Feed.html 호출
  •/feed에서 왼쪽 상단 개인정보에 로그인한 사람의 아이디, 게시물 수,
  팔로워 수, 팔로윙 수가 반영되도록 작성
  •/feed에서 로그아웃 클릭 시 /login으로 이동
  •/feed에서 우측에 작성된 모든 글이 보이도록 작성
  •/{로그인한 ID}에서 자신과 팔로우 한 사람의 글이 보이도록 작성
  •/{다른 사람 ID}에서는 그 사람이 작성한 글만 보이도록 작성

개인 페이지 기능
  •/feed에 뜨는 자신의 아이디를 클릭 시 /{로그인한 ID}로 이동
  •/{로그인한 ID}에서 MyPage.html 호출
  •/feed 또는 /{로그인한 ID}에서 다른 사람 아이디 클릭 시,
  /{다른 사람 ID} 호출
  •/{다른 사람 ID}에서 PersonalPage.html 호출
  •/feed에서 왼쪽 상단 개인정보에 로그인한 사람의 아이디, 게시물 수,
  팔로워 수, 팔로윙 수가 반영되도록 작성
  •/{로그인한 ID}에서 로그아웃 클릭 시 /login으로 이동
  •/{로그인한 ID} 또는 /{다른 사람 ID}에서 홈으로 클릭 시 /feed로 이동

팔로우 기능
  •/{다른 사람 ID}에서 팔로우를 누를 경우 팔로우 등록과 취소를 구현',
                      :description => 'Tip
  •/mysql workbench에 "feed"라는 스키마를 생성하고 "src/main/java/com.feed/application.properties"에서 spring.datasource.password에 본인의 mysql password를 입력하시오.')
challenge02 = Challenge.create(:title => 'Board Test',
                               :goal => 'Spring을 활용한 다양한 기능 완성하기',
                               :information => '게시판 홈 기능
  •/ 에서 Home.html을 호출
  •등록된 모든 게시물(post) 객체들을 id 내림차순으로 보이도록 작성
  •/ 에서 글쓰기 버튼 클릭 시 /write로 이동
  •/ 게시물의 제목 클릭 시 /postview/{id} 주소로 이동

게시물 작성 기능
  •/write에서 Write.html 호출
  •/write에서 닉네임, 제목, 내용을 작성 클릭 시 값이 저장되면서 /postview/{id}로 이동
  •게시물 작성 시 날짜를 DB에 저장
  •닉네임 또는 제목이 빈칸인 경우 ErrorPage.html 호출

게시물 포스트뷰 기능
  •/postview/{id} 에서 PostView.html 호출
  •해당 id의 닉네임, 내용, 날짜, 조회수를 띄우도록 작성
  •/ 에서 /postview/{id}로 이동 시 조회수 1 증가
  •/postview/{id}에서 뒤로 버튼 클릭 시 /로 이동
  •/postview/{id}에서 삭제 버튼 클릭 시 게시물 삭제 후 /로 이동
  •/postview/{id}에서 수정 버튼 클릭 시 /postview/modify/{id}로 이동

게시물 수정 기능
  •/postview/modify/{id}에서 Modify.html을 호출
  •/postview/modify/{id}로 넘어왔을 때 기존의 내용이 뜨도록 작성
  •/postview/modify/{id}에서 수정 버튼을 클릭 시 수정된 내용이 반영되고, /postview/{id}로 이동
  •수정 버튼 클릭 시 닉네임 또는 제목이 공백일 경우 ErrorPage.html을 호출',
                               :description => 'Tip
  - non')
challenge01.save
challenge02.save

user01 = Applicant.create(:name => 'Cha',
                      :email => 'aaa@gmail.com',
                      :challenge => challenge01)
user02 = Applicant.create(:name => 'Jeon',
                          :email => 'bbb@gmail.com',
                          :challenge => challenge02)
user03 = Applicant.create(:name => 'Hong01',
                          :email => 'ccc@gmail.com',
                          :challenge => challenge01)
user04 = Applicant.create(:name => 'Jung',
                          :email => 'ddd@gmail.com',
                          :challenge => challenge02)
user05 = Applicant.create(:name => 'Hong02',
                          :email => 'eee@gmail.com',
                          :challenge => challenge01)
user01.save
user02.save
user03.save
user04.save
user05.save
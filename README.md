#Web_Rails

 응시자, 관리자가 프로젝트 관리능력을 시험할 수 있는 서버입니다.
 
OS : Ubuntu

IDE : RubyMine

필요 환경 : Rails 5.0.1 이상, Docker(img:denniscah50/board)
MySQL, MySQL workbench


실행방법
1. 처음 실행시 - 터미널 - sudo rake db:drop, sudo rake db:migrate, sudo rake db:seed
2. DB에서 응시자의 토큰 확보
3. 터미널 - sudo rails s
4. Web - localhost:3000(관리자), localhost:3000/challenges/4?token='토큰' (응시자)

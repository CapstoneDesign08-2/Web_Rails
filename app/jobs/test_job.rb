# encoding: euc-kr
class TestJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :test_queue

  def perform(*result1)
    # 실행할 작업
    @result = ApplicantResultAtChallenge.create(:applicant_id => @result1.applicant_id,
                                                :challlenge_id => @result1.challenge_id)

    @result.log = nil
    @result.score = 0
    @result.save
    @docker = getTestDocker @result.applicant_id
    deleteDocker
    if @result.language == 'SpringBoot'
      createSpringTestDocker
      springTest
    elsif  @result.language == 'RubyonRails'
      createRailsTestDocker
      railsTest
    else
      deleteDocker
      puts "Framework was not selected"
    end
  end

  def getTestDocker(id)
    begin
      return Docker::Container.get("applicant_#{id}_test")
    rescue
      return nil
    end
  end

  def springTest
    @command = ['bash', '-c', 'gradle test']
    @print = @docker.exec(@command)
    #puts @print
    puts "---------------------------------------"
    @answer = "answer : "
    for i in 0..1
      @print[i].each do |tmp|
        @answer.concat(tmp)
      end
    end
    puts @answer
    #puts @print.to_s.encode("UTF-8", "EUC-KR")
    @numberOfPassed = @answer.scan("PASSED").size
    @arrFailMessages = @answer.scan(/\$[^#]+#/)
    @failMessage = "FAIL LOG : \n"

    if @arrFailMessages.size > 1
      @arrFailMessages.each do |tmp|
        @failMessage = @failMessage.concat(tmp)+'<br>'
      end
    else
      @failMessage = "SUCCESS"
    end

    @result.log = @failMessage
    @result.score = 100 - (@arrFailMessages.size * 5)
    @result.save
    # delete
    deleteDocker
    #rescue
     # delete_docker
      #puts "applicant_#{@applicant.id} spring test failed"
    #end
  end

  def railsTest
    begin
      @command = ['bash', '-c', 'rails test test/controllers/test_rails.rb']
      @print = @docker.exec(@command)
      #puts @print
      puts "---------------------------------------"
      @answer = "answer : "
      for i in 0..1
        @print[i].each do |tmp|
          @answer.concat(tmp)
        end
      end
      puts @answer
      #puts @print.to_s.encode("UTF-8", "EUC-KR")
      #@numberOfPassed = @answer.scan("PASS").size
      @arrMessages = @answer.scan(/\$[^#]+#/)
      @arrFailMessages = Array.new

      @arrMessages.each do |msg|
        if (msg =~ /(.*)PASS(.*)/) == nil
          @arrFailMessages.push(msg)
        end
      end
      @failMessage = "FAIL LOG : \n"

      if @arrFailMessages.size > 1
        @arrFailMessages.each do |tmp|
          @failMessage = @failMessage.concat(tmp)+'<br>'
        end
      else
        @failMessage = "SUCCESS"
      end

      @result.log = @failMessage
      @result.score = 100 - (@arrFailMessages.size * 12)
      @result.save
      # delete
      deleteDocker
    rescue
      deleteDocker
      puts "applicant_#{@result.applicant_id} spring test failed"
    end
  end
end

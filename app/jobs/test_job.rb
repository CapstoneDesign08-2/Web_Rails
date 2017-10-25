# encoding: euc-kr
class TestJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :test_queue

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @applicant.log = nil
    @applicant.score = 0
    @applicant.save
    @docker = getTestDocker @applicant.id
    deleteDocker
    if @applicant.language == 'SpringBoot'
      createSpringTestDocker
      springTest
    elsif  @applicant.language == 'RubyonRails'
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

    @applicant.log = @failMessage
    @applicant.score = 100 - (@arrFailMessages.size * 5)
    @applicant.save
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

      @applicant.log = @failMessage
      @applicant.score = 100 - (@arrFailMessages.size * 12)
      @applicant.save
      # delete
      deleteDocker
    rescue
      deleteDocker
      puts "applicant_#{@applicant.id} spring test failed"
    end
  end
end

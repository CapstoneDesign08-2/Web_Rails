class RunJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :run_queue

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @docker = getDocker @applicant.id
    begin
      deleteDocker
      if @applicant.language == 'SpringBoot'
        createSpringRunDocker
      elsif  @applicant.language == 'RubyonRails'
        createRailsRunDocker
      else
        deleteDocker
        puts "Framework was not selected"
      end
    rescue
      if @docker != nil
        @docker.delete(force: true)
      end
      puts "applicant_#{@applicant.id} docker run failed"
    end
  end

  def getDocker(id)
    begin
      return Docker::Container.get("applicant_#{id}_run")
    rescue
      return nil
    end
  end

end

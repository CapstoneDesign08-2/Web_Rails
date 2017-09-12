class RunJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :run_queue

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @docker = get_docker @applicant.id
    begin
      delete_docker
      if @applicant.language == 'SpringBoot'
        create_spring_run_docker
      elsif  @applicant.language == 'RubyonRails'
        create_rails_run_docker
      else
        delete_docker
        puts "Framework was not selected"
      end
    rescue
      if @docker != nil
        @docker.delete(force: true)
      end
      puts "applicant_#{@applicant.id} docker run failed"
    end
  end

  def get_docker(id)
    begin
      return Docker::Container.get("applicant_#{id}_run")
    rescue
      return nil
    end
  end

end

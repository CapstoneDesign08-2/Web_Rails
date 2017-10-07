class ApplicationJob < ActiveJob::Base

  $project_unzip_path = "/home/user/R/Web_Rails/unzip"

  def create_spring_test_docker
    begin
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_test",
        'Image': 'dennischa50/board',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
        'Binds': ["#{$project_unzip_path}/#{@applicant.id}:/home"]
        })
    @docker.start
    @command = ['bash', '-c', 'gradle clean']
    @docker.exec(@command)
      return @docker
    rescue
      puts "applicant_#{@applicant.id} spring docker failed to create"
      delete_docker
      return nil
    end

  end

  def create_rails_test_docker
    begin
      @docker = Docker::Container.create(
          'name': "applicant_#{@applicant.id}_test",
          'Image': 'dennischa50/board_rails',
          'Tty': true,
          'Interactive': true,
          'ExposedPorts': { '8080/tcp' => {} },
          'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
                         'Binds': ["#{$project_unzip_path}/#{@applicant.id}:/home"]
          })
      @docker.start
      #@command = ['bash', '-c', 'gradle clean']
      #@docker.exec(@command)
    rescue
      puts "applicant_#{@applicant.id} RAILS docker failed to create"
      delete_docker
    end
  end

  def create_spring_run_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_run",
        'Image': 'dennischa50/board',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "110#{@applicant.id}"}]},
        'Binds': ["#{$project_unzip_path}/#{@applicant.id}:/home"]
    })
    @docker.start
    @command = ['bash', '-c', 'gradle run']
    @docker.exec(@command, detach: true)
  end

  def create_rails_run_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_run",
        'Image': 'dennischa50/board_rails',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '3000/tcp' => {} },
        'HostConfig': {'PortBindings': {'3000/tcp' => [{'HostPort' => "110#{@applicant.id}"}]},
                       'Binds': ["#{$project_unzip_path}/#{@applicant.id}:/home"]
        })
    @docker.start
    @command = ['bash', '-c', 'rails s']
    @docker.exec(@command, detach: true)
  end


  def delete_docker
    if @docker != nil
      @docker.delete(force: true)
    end
  end

end

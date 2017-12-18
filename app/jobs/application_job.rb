class ApplicationJob < ActiveJob::Base

  $project_unzip_path = "#{__dir__}/../../unzip"
  $applicantPort=0
  $createPort=5000
  $runPort=6000

  def createSpringTestDocker
    begin
      $applicantPort= $createPort + @result.applciant_id
    @docker = Docker::Container.create(
        'name': "applicant_#{@result.applciant_id}_test",
        'Image': 'dennischa50/board',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "#{$applicantPort}"}]},
        'Binds': ["#{$project_unzip_path}/#{@result.applciant_id}:/home"]
        })
    @docker.start
    @command = ['bash', '-c', 'gradle clean']
    @docker.exec(@command)
      return @docker
    rescue
      puts "applicant_#{@result.applciant_id} spring docker failed to create"
      deleteDocker
      return nil
    end

  end

  def createRailsTestDocker
    begin
      $applicantPort= $createPort + @result.applciant_id
      @docker = Docker::Container.create(
          'name': "applicant_#{@result.applciant_id}_test",
          'Image': 'dennischa50/board_rails',
          'Tty': true,
          'Interactive': true,
          'ExposedPorts': { '8080/tcp' => {} },
          'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "#{$applicantPort}"}]},
                         'Binds': ["#{$project_unzip_path}/#{@result.applciant_id}:/home"]
          })
      @docker.start
      #@command = ['bash', '-c', 'gradle clean']
      #@docker.exec(@command)
    rescue
      puts "applicant_#{@result.applciant_id} RAILS docker failed to create"
      deleteDocker
    end
  end

  def createSpringRunDocker
    $applicantPort= $runPort + @result.applciant_id
    @docker = Docker::Container.create(
        'name': "applicant_#{@result.applciant_id}_run",
        'Image': 'dennischa50/board',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "#{$applicantPort}"}]},
        'Binds': ["#{$project_unzip_path}/#{@result.applciant_id}:/home"]
    })
    @docker.start
    @command = ['bash', '-c', 'gradle run']
    @docker.exec(@command, detach: true)
  end

  def createRailsRunDocker
    $applicantPort= $runPort + @result.applciant_id
    @docker = Docker::Container.create(
        'name': "applicant_#{@result.applciant_id}_run",
        'Image': 'dennischa50/board_rails',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '3000/tcp' => {} },
        'HostConfig': {'PortBindings': {'3000/tcp' => [{'HostPort' => "#{$applicantPort}"}]},
                       'Binds': ["#{$project_unzip_path}/#{@result.applciant_id}:/home"]
        })
    @docker.start
    @command = ['bash', '-c', 'rails s']
    @docker.exec(@command, detach: true)
  end


  def deleteDocker
    if @docker != nil
      @docker.delete(force: true)
    end
  end

end

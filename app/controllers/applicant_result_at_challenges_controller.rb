class Applicant_result_at_challengeController
  before_action :setResult, only: [:update, :logging, :building, :score]
  before_action :setDocker, only: [:update]
  def new
    @result = ApplicantResultAtChallenge.new
  end
  def create
    @challenges = Challenge.all
    @applicant = Applicant.all
    @result = ApplicantResultAtChallenge.new(resultParams)
    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  def logging
    render plain:@result.log
  end
  def score
    render plain:@result.score
  end
  def update
    respond_to do |format|
      if @result.update(@result.resultParams)
        format.html {redirect_to @applicant.challenge, notice: 'Applicant was successfully updated'}
        if @result.attachment != nil
          #puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
          output = system("rm -f -r #{__dir__}/../../unzip/#{@applicant.id}/")
          output = system("unzip -o ./public/#{@applicant.attachment} -d ./unzip/#{@applicant.id} ")
          puts  "unzip : #{output}"

          #output = system("sudo rm -r ./unzip/#{@applicant.id}/src/test")
          #output = system("sudo cp -r ./tmp/test ./unzip/#{@applicant.id}/src")
          #output = system("sudo rm -f ./public/#{@applicant.attachment}")
          #puts "rm : #{output}"
          #output = system("cd ./unzip/#{@applicant.id} && zip -r ../../public#{@applicant.attachment} ./*")
          #puts "zip : #{output}"
          # upload S3
          #@applicant.attachments3 = @applicant.attachment
        end
      else
        format.html {render :edit}
      end
    end
    @result.update(@result.resultParams)
  end

  def building
    RunJob.perform_later @result.applicant_id
    require 'timers'
    timers = Timers::Group.new

    pausedTimer = timers.every(7) { puts "5sec paused" }

    pausedTimer.resume
    10.times { timers.wait } # will fire timer

    @docker = getDocker @result.applicant_id

    @docker.delete(force: true)

    begin

    rescue
      puts "applicant_#{@result.applicant_id} docker stop failed"
    end

    render :show
  end

  def getDocker(id)
    begin
      return Docker::Container.get("applicant_#{id}_run")
    rescue
      return nil
    end
  end


  private
  def setResult
    @result = ApplicantResultAtChallenge.where("applicant_id=? AND challenge_id=?",params(:applicant_id),params(:challenge_id))
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def resultParams
    params.require(:applicant_result_at_challenge).permit(:score, :attachment, :log,:challenge_id,:applicant_id)
  end
  def setDocker
    begin
      @docker = Docker::Container.get("applicant_#{@result.applicant_id}")
    rescue
      @docker = nil
    end
  end
end
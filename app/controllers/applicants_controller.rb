class ApplicantsController < ApplicationController
  before_action :setApplicant, only: [:show, :edit, :update, :destroy, :logging, :building, :score]
  before_action :setDocker, only: [:update, :show]

  def index
    @applicants = Applicant.all
  end

  def show
    render :show
  end

  def new
    @challenges = Challenge.all
    @applicant = Applicant.new
  end

  def edit
    @challenges = Challenge.all
  end

  def logging
    render plain:@applicant.log
  end
  def score
    render plain:@applicant.score
  end

  def building
    RunJob.perform_later @applicant.id
    sleep(5.minutes)

    @docker = getDocker @applicant.id

    @docker.delete(force: true)

    begin

    rescue
      puts "applicant_#{@applicant.id} docker stop failed"
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

  def create
    @challenges = Challenge.all

    @applicant = Applicant.new(applicantParams)
    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @applicant.update(applicantParams)
        format.html {redirect_to @applicant.challenge, notice: 'Applicant was successfully updated'}
        if @applicant.attachment != nil
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
    @applicant.update(applicantParams)
  end

  def destroy
    @applicant.destroy
    respond_to do |format|
      format.html {redirect_to applicants_url, notice: 'Applicant was successfully destroyed. ' }
    end
  end

  def page

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def setApplicant
    @applicant = Applicant.find(params[:id])
  end

  def setDocker
    begin
      @docker = Docker::Container.get("applicant_#{@applicant.id}")
    rescue
      @docker = nil
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def applicantParams
    params.require(:applicant).permit(:name, :email, :score, :token, :challenge_id, :attachment, :id, :log, :language)
  end
end


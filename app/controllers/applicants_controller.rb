class ApplicantsController < ApplicationController
  before_action :setApplicant, only: [:show, :edit,  :destroy]

  def index
    @applicants = Applicant.all
  end

  def show
    render :show
  end

  def new
    @challenges = Challenge.all
    @applicant = Applicant.new
    @result = ApplicantResultAtChallenge.all
  end
  def edit
    @challenges = Challenge.all
    @result = ApplicantResultAtChallenge.all
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



  # Never trust parameters from the scary internet, only allow the white list through.
  def applicantParams
    params.require(:applicant).permit(:name, :email, :token, :id)
  end

end


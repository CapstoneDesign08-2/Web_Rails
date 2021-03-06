class ChallengesController < ApplicationController
  before_action :setChallenge, only: [:show, :destroy, :update, :edit, :result]
  before_action :setApplicant, only: [:show, :update, :result]

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challengeParams)
    if @challenge.save
      redirect_to challenges_path
    else
      render 'new'
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path
  end
  def result
  end
  def show
  end

  def update
    respond_to do |format|
      format.json {render plain: @applicant.log}
      TestJob.perform_later @applicant.id
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def setChallenge
    @challenge = Challenge.find(params[:id])
  end

  def setApplicant
    @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: params[:token])
    if @applicant
      log_in @applicant
    else
      @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: session[:token])
      render json: {error: 'Not Authorized'}, status: 401 unless @applicant
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challengeParams
    params.require(:challenge).permit(:title, :description)
  end
end
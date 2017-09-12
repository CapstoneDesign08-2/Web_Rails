module ChallengesHelper
  def log_in(applicant)
    session[:token] = applicant.token
  end

  def current_user
    @current_user ||= Applicant.find_by(token: session[:token])
  end

  def user_signed_in?
    !current_user.nil?
  end
end

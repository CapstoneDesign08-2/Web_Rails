require 'test_helper'

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get applicants_upload_url
    assert_response :success
  end

end

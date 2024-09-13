module ControllerHelpers
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:user_id).and_return(user.id)
  end
end

module LoginTestHelper
  extend self

  def login_as user
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
end

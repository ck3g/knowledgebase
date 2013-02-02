require 'spec_helper'

describe UsersController do
  login_admin
  let(:user) { subject.current_user }

  describe "GET #profile" do
    before { get :profile }
    it { should assign_to(:user).with user }
    it { should respond_with :success }
    it { should render_template :profile }
  end
end

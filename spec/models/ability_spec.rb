require "spec_helper"
require "cancan/matchers"

describe Ability do
  let!(:user) { create :user }
  let!(:admin) { create :admin }
  let!(:editor) { create :editor }
  let!(:user_skill) { create :skill, user: user }
  let!(:admin_skill) { create :skill, user: admin }

  describe "as guest" do
    subject { Ability.new nil }
    it { should_not be_able_to :read, User }
    it { should_not be_able_to :read, Skill }
    it { should_not be_able_to :manage, Skill }
  end

  describe "as admin" do
    subject { Ability.new create(:admin) }
    it { should be_able_to :all, User }
    it { should be_able_to :all, Skill }
  end

  describe "as editor" do
    subject { Ability.new create(:editor) }
    it { should_not be_able_to :all, User }
    it { should be_able_to :all, Skill }
  end

  describe "as registered user" do
    let!(:user) { create :user }
    subject { Ability.new user }
    it { should be_able_to :manage, user_skill }
    it { should_not be_able_to :manage, admin_skill }
  end
end

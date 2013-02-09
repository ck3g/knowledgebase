require "spec_helper"
require "cancan/matchers"

shared_examples "acts as editor" do
  it { should be_able_to :all, Skill }
  it { should be_able_to :manage, user_question }
  it { should be_able_to :manage, admin_question }
  it { should be_able_to :manage, Question }
  it { should be_able_to :manage, Answer }
  it { should be_able_to :manage, user_answer }
  it { should be_able_to :manage, admin_answer }
end

describe Ability do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:editor) { create :editor }

  let(:user_skill) { build :skill, user: user }
  let(:admin_skill) { build :skill, user: admin }

  let(:user_question) { build :question, user_id: user.id }
  let(:admin_question) { build :question, user_id: admin.id }

  let(:user_answer) { build :answer, user_id: user.id }
  let(:admin_answer) { build :answer, user_id: admin.id }

  describe "as guest" do
    subject { Ability.new nil }
    it { should_not be_able_to :read, User }
    it { should_not be_able_to :all, Skill }
    it { should_not be_able_to :all, Question }
    it { should_not be_able_to :all, Answer }
  end

  describe "as admin" do
    subject { Ability.new create(:admin) }
    it { should be_able_to :all, User }
    it_behaves_like "acts as editor"
  end

  describe "as editor" do
    subject { Ability.new create(:editor) }
    it { should_not be_able_to :all, User }
    it_behaves_like "acts as editor"
  end

  describe "as registered user" do
    let!(:user) { create :user }
    subject { Ability.new user }
    it { should be_able_to :manage, user_skill }
    it { should_not be_able_to :manage, admin_skill }
    it { should be_able_to :manage, user_question }
    it { should_not be_able_to :manage, admin_question }
    it { should be_able_to :read, Question }
    it { should be_able_to :manage, user_answer }
    it { should_not be_able_to :manage, admin_answer }
  end
end

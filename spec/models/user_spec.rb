require 'spec_helper'

describe User do
  let!(:user) { create :user }
  let!(:admin) { create :admin }

  it "has a valid factory :user" do
    expect(create :user).to be_valid
  end

  it "has a valid factory :admin" do
    expect(create :admin).to be_valid
  end

  it "has a valid factory :user_with_codes" do
    expect(create :user_with_codes).to be_valid
  end

  describe ".associations" do
    it { should embed_many :invite_codes }
    it { should embed_many :roles }
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :username }
      it { should validate_presence_of :email }
      it { should validate_uniqueness_of :username }
      it { should validate_uniqueness_of :email }
    end

    context "when need invitation" do
      let!(:user) { create :user_with_codes }
      let!(:code) { user.invite_codes.last.code }
      subject { build :user, invite_code: code, need_invitation: true }
      it { should validate_inclusion_of(:invite_code).to_allow(code)}
      it { should_not allow_value("wrong-code").for(:invite_code).with_message("Invite code is invalid") }
    end
  end

  describe "create user" do
    let!(:invited_by) { create :user_with_codes }
    let(:invite) { invited_by.invite_codes.first }
    let!(:user) { create :user, need_invitation: true, invite_code: invite.code }

    it "store invited by id" do
      expect(user.invited_by_user_id).to eq invited_by.id
    end

    it "mark code as used" do
      expect(invite.reload.used).to be_true
    end
  end

  describe "#admin?" do
    context "when user is admin" do
      it { expect(admin.admin?).to be_true }
    end

    context "when user isn't admin" do
      it { expect(user.admin?).to be_false }
    end
  end
end

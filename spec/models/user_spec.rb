require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(create :user).to be_valid
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :username }
      it { should validate_presence_of :email }
      it { should validate_uniqueness_of :username }
      it { should validate_uniqueness_of :email }
    end
  end
end

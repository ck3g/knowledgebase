require 'spec_helper'

describe Skill do
  it "has a valid factory" do
    expect(create :skill).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end
  end
end

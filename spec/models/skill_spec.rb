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

  describe "#new?" do
    context "when created today" do
      let!(:new_skill) { create :skill }
      it { expect(new_skill.new?).to be_true }
    end

    context "when created 5 days ago" do
      let(:old_skill) { create :skill, created_at: 5.days.ago }
      it { expect(old_skill.new?).to be_false }
    end
  end
end

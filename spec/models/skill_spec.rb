require 'spec_helper'

describe Skill do
  it "has a valid factory" do
    expect(create :skill).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should embed_many :questions }
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end
  end

  describe ".scopes" do
    describe ".tagged" do
      let!(:ruby_skill) { create :skill, tags: ["ruby"] }
      let!(:rails_skill) { create :skill, tags: ["rails", "ruby"] }
      context "when tag is 'rails'" do
        it "select only rails skill" do
          expect(Skill.tagged("rails").to_a).to eq [rails_skill]
        end
      end

      context "when tag is 'rails'" do
        it "select both skills" do
          expect(Skill.tagged("ruby").to_a).to eq [ruby_skill, rails_skill]
        end
      end
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

require 'spec_helper'

describe Answer do
  it "has a valid factory" do
    expect(build :answer).to be_valid
  end

  describe ".associations" do
    it { should belong_to :user }
    it { should be_embedded_in :question }
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :content }
      it { should validate_presence_of :user_id }
      it { should validate_numericality_of :rating }
    end
  end
end

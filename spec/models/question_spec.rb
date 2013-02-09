require 'spec_helper'

describe Question do
  it "has a valid factory" do
    expect(create :question).to be_valid
  end

  describe ".associations" do
    it { should be_embedded_in :skill }
    it { should embed_many :answers }
  end

  describe ".validation" do
    it { should validate_presence_of :title }
  end
end

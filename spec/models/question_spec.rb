require 'spec_helper'

describe Question do
  it "has a valid factory" do
    expect(create :question).to be_valid
  end

  describe ".associations" do
    it { should be_embedded_in :skill }
  end
end

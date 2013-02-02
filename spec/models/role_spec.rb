require 'spec_helper'

describe Role do
  it "has a valid factory" do
    expect(create :role).to be_valid
  end

  describe ".associations" do
    it { should be_embedded_in :user }
  end

  describe ".validations" do
    context "when valid" do
      it { should validate_presence_of :name }
      it { should validate_inclusion_of(:name).to_allow("admin", "editor")}
    end
  end
end

require 'spec_helper'

describe InviteCode do
  let!(:code1) { create(:invite_code).code }
  let!(:code2) { create(:invite_code).code }
  let!(:code3) { create(:invite_code, used: true).code }

  it "has a valid factory" do
    expect(create :invite_code).to be_valid
  end

  describe ".associations" do
    it { should be_embedded_in :user }
  end

  describe ".codes" do
    it "find all codes" do
      expect(InviteCode.codes).to eq [code1, code2, code3]
    end
  end

  describe ".unused_codes" do
    it "find only unused codes" do
      expect(InviteCode.unused_codes).to eq [code1, code2]
    end
  end
end

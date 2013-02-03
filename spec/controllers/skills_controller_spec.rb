require 'spec_helper'

describe SkillsController do
  login_admin
  let(:user) { subject.current_user }
  let!(:ruby_skill) { create :skill, name: "Ruby" }
  let!(:rails_skill) { create :skill, name: "Ruby on Rails" }

  describe "GET #index" do
    before { get :index }
    it { should assign_to(:skills).with [rails_skill, ruby_skill] }
    it { should render_template :index }
    it { should respond_with :success }
  end

  describe "GET #new" do
    before { get :new }
    it { should assign_to(:skill).with_kind_of Skill }
    it { should render_template :new }
    it { should respond_with :success }
  end

  describe "POST #create" do
    context "when valid" do
      before { post :create, skill: attributes_for(:skill, tags: "ruby, rails") }
      it { should assign_to(:skill).with_kind_of Skill }
      it { should redirect_to Skill.last }
      it "save tags properly" do
        expect(Skill.last.tags).to eq %w(ruby rails)
      end
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates new skill" do
        expect {
          post :create, skill: attributes_for(:skill)
        }.to change(Skill, :count).by(1)
      end
    end

    context "when invalid" do
      before { post :create, skill: attributes_for(:invalid_skill) }
      it { should render_template :new }
      it "don't creates new skill" do
        expect {
          post :create, skill: attributes_for(:invalid_skill)
        }.to_not change(Skill, :count).by(1)
      end
    end
  end

  describe "GET #show" do
    before { get :show, id: ruby_skill.id }
    it { should assign_to(:skill).with ruby_skill }
    it { should render_template :show }
    it { should respond_with :success }
  end

  describe "GET #edit" do
    before { get :edit, id: ruby_skill.id }
    it { should assign_to(:skill).with ruby_skill }
    it { should render_template :edit }
    it { should respond_with :success }
  end

  describe "PUT #update" do
    context "when valid attributes" do
      before { put :update, id: ruby_skill, skill: attributes_for(:skill, tags: "ruby2, rails4") }
      it { should assign_to(:skill).with ruby_skill }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "save tags properly" do
        ruby_skill.reload
        expect(ruby_skill.tags).to eq %w(ruby2 rails4)
      end
      it "updated the attribute" do
        expect {
          put :update, id: ruby_skill, skill: attributes_for(:skill, name: "Ruby 2.0")
          ruby_skill.reload
        }.to change(ruby_skill, :name).to("Ruby 2.0")
      end
    end

    context "when invalid attributes" do
      before { put :update, id: ruby_skill, skill: attributes_for(:invalid_skill) }
      it { should assign_to(:skill).with ruby_skill }
      it { should render_template :edit }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, id: ruby_skill.id }
    it { should redirect_to skills_path }
    it "deletes the skill" do
      expect {
        delete :destroy, id: rails_skill.id
      }.to change(Skill, :count).by(-1)
    end
  end
end

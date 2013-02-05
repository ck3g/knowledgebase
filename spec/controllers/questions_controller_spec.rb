require 'spec_helper'

shared_examples "assigns skill and question" do
  it { should assign_to(:skill).with skill }
  it { should assign_to(:question).with question }
end

describe QuestionsController do
  login_admin

  let(:skill) { create :skill }
  let(:question) { create :question, skill: skill }
  let(:question2) { create :question, skill: skill }

  describe "GET #index" do
    context "when format html" do

    end

    context "when format json" do
      before { xhr :get, :index, skill_id: skill }
      it { should respond_with_content_type :json }
    end
  end

  describe "GET #new" do
    before { get :new, skill_id: skill }
    it { should assign_to(:skill).with skill }
    it { should respond_with :success }
    it { should render_template :new }
  end

  describe "GET #show" do
    before { get :show, skill_id: skill, id: question }
    it_behaves_like "assigns skill and question"
    it { should respond_with :success }
    it { should render_template :show }
  end

  describe "GET #edit" do
    before { get :edit, skill_id: skill, id: question }
    it_behaves_like "assigns skill and question"
    it { should respond_with :success }
    it { should render_template :edit }
  end

  describe "PUT #update" do
    before { put :update, skill_id: skill, id: question, question: attributes_for(:question, title: "New title") }
    it_behaves_like "assigns skill and question"
    it { should redirect_to [skill, question] }
    it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }

    it "changes the title" do
      expect {
        put :update, skill_id: skill, id: question, question: attributes_for(:question, title: "New title")
        question.reload
      }.to change(question, :title).to("New title")
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, skill_id: skill, id: question }
    it_behaves_like "assigns skill and question"
    it { should redirect_to skill }
    it "deletes the question" do
      expect {
        delete :destroy, skill_id: skill.id, id: question2.id
        skill.reload
      }.to change(skill, :questions).to([])
    end
  end
end

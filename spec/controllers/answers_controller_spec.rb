require 'spec_helper'

describe AnswersController do
  login_admin

  let(:skill) { create :skill }
  let(:question) { create :question, skill: skill }
  let!(:first_answer) { create :answer, question: question }
  let(:answer) { create :answer, question: question }

  describe "POST #create" do
    context "with valid parameters" do
      before { post :create, skill_id: skill, question_id: question, answer: attributes_for(:answer) }
      it { should assign_to(:answers) }
      it { should assign_to(:answer).with_kind_of Answer }
      it { should redirect_to skill_question_path(skill, question, anchor: "answers") }
      it { should set_the_flash[:notice].to I18n.t(:created_successfully) }
      it "creates the answer" do
        question.reload
        expect(question.answers.count).to eq 2
      end
    end

    context "with invalid parameters" do
      before { post :create, skill_id: skill, question_id: question, answer: attributes_for(:invalid_answer) }
      it { should respond_with :success }
      it { should render_template "questions/show" }
      it "don't creates the answer" do
        expect {
          post :create, skill_id: skill, question_id: question, answer: attributes_for(:invalid_answer)
        }.to_not change(question.answers, :count)
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, skill_id: skill, question_id: question, id: answer }
    it { should respond_with :success }
    it { should render_template :edit }
    it { should assign_to(:answer).with answer }
  end

  describe "PUT #update" do
    context "with valid parameters" do
      before { put :update, skill_id: skill, question_id: question, id: answer, answer: attributes_for(:answer) }
      it { should redirect_to skill_question_path(skill, question, anchor: "answer_#{answer.id}") }
      it { should assign_to(:answer).with answer }
      it { should assign_to(:answers) }
      it "changes the answer" do
        expect {
          put :update, skill_id: skill, question_id: question, id: answer, answer: attributes_for(:answer, content: "New answer" )
          answer.reload
        }.to change(answer, :content).to("New answer")
      end
    end

    context "with invalid parameters" do
      before { put :update, skill_id: skill, question_id: question, id: answer, answer: attributes_for(:invalid_answer) }
      it { should render_template :edit }
    end
  end

  describe "DELETE #destroy" do
    let!(:answer) { create :answer, question: question }
    before do
      xhr :delete, :destroy, skill_id: skill, question_id: question, id: answer
    end
    it { should respond_with :success }
    it { should render_template :destroy }
    it "deletes the answer" do
      question.reload
      expect(question.answers).to eq [first_answer]
    end
  end
end

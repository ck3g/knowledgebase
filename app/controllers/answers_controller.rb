class AnswersController < ApplicationController
  authorize_resource

  before_filter :find_skill
  before_filter :find_question
  before_filter :find_answer, only: [:edit, :update, :destroy]

  def create
    @answer = @answers.new params[:answer]
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to skill_question_path(@skill, @question, anchor: "answers"), notice: t(:created_successfully)
    else
      render "questions/show"
    end
  end

  def edit

  end

  def update
    if @answer.update_attributes params[:answer]
      redirect_to skill_question_path(@skill, @question, anchor: "answer_#{@answer.id}"), notice: t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
  end

  private
  def find_skill
    @skill = Skill.find params[:skill_id]
  end

  def find_question
    @question = @skill.questions.find params[:question_id]
    @answers = @question.answers
  end

  def find_answer
    @answer = @answers.find params[:id]
  end
end

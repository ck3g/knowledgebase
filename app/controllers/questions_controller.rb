class QuestionsController < ApplicationController
  authorize_resource
  before_filter :find_skill
  before_filter :find_question, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render json: @skill.questions.map(&:to_jq_upload) }
    end
  end

  def create
    @question = @skill.questions.new params[:question]
    @question.user_id = current_user.id
    @question.title = params[:question][:picture].original_filename

    respond_to do |format|
      if @question.save
        format.html {
          render :json => [@question.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@question.to_jq_upload].to_json, status: :created, location: skill_question_path(@skill, @question) }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

   def update
    if @question.update_attributes params[:question]
      redirect_to [@skill, @question], notice: t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to @skill
  end

  private
  def find_skill
    @skill = Skill.find params[:skill_id]
  end

  def find_question
    @question = @skill.questions.find params[:id]
  end
end

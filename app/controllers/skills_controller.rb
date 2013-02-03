class SkillsController < ApplicationController
  load_and_authorize_resource

  def index
    @skills = Skill.desc(:created_at)
  end

  def new
  end

  def create
    @skill = current_user.skills.new build_params(params[:skill])
    if @skill.save
      redirect_to @skill, notice: I18n.t(:created_successfully)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @skill.tags = @skill.tags.join(", ") if @skill.tags.is_a? Array
  end

  def update
    if @skill.update_attributes build_params(params[:skill])
      redirect_to @skill, notice: I18n.t(:updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    @skill.destroy
    redirect_to skills_path
  end

  private
  def build_params(params)
    if params[:tags].is_a? String
      params[:tags] = params[:tags].split(",").map(&:strip)
    end

    params
  end
end

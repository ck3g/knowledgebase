class SkillQuery
  def initialize(relation = Skill.scoped)
    @relation = relation
  end

  def find_all(params)
    @relation = @relation.tagged(params[:tag]) if params[:tag].present?
    @relation.desc(:created_at)
  end
end

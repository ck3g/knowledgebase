class Skill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description
  field :user_id, type: Moped::BSON::ObjectId
  field :tags, type: Array

  attr_accessible :name, :description, :tags

  belongs_to :user
  embeds_many :questions, validate: false

  validates :name, presence: true, uniqueness: true

  scope :tagged, ->(name) { where(tags: name) }

  def new?
    created_at > 3.days.ago
  end

  def prepare_tags!
    self.tags = self.tags.join(", ") if self.tags.is_a? Array
  end
end

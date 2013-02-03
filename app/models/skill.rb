class Skill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description
  field :user_id, type: Moped::BSON::ObjectId
  field :tags, type: Array

  attr_accessible :name, :description, :tags

  belongs_to :user
  embeds_many :questions

  validates :name, presence: true, uniqueness: true

  def new?
    created_at > 3.days.ago
  end
end

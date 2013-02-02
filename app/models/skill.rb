class Skill
  include Mongoid::Document

  field :name
  field :description
  field :user_id, type: Moped::BSON::ObjectId
  field :tags, type: Array

  attr_accessible :name, :description, :tags

  belongs_to :user

  validates :name, presence: true, uniqueness: true
end

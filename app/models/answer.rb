class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content
  field :proof_link
  field :user_id, type: Moped::BSON::ObjectId
  field :accepted, type: Boolean, default: false
  field :rating, type: Integer, default: 0

  belongs_to :user
  embedded_in :question

  attr_accessible :content, :proof_link

  validates :content, :user_id, presence: true
  validates :rating, numericality: { only_integer: true }

  delegate :username, to: :user, prefix: true

  def skill
    question.skill
  end
end

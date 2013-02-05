class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  include Rails.application.routes.url_helpers

  field :title
  field :description
  field :answered, type: Boolean, default: false
  field :user_id
  field :picture

  embedded_in :skill

  mount_uploader :picture, PictureUploader

  attr_accessible :picture, :picture_cache, :title, :description

  validates :title, presence: true

  scope :answered, where(answered: true)

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "title" => self.title,
      "success_text" => "Question \"#{self.title}\" #{I18n.t(:created_successfully)}",
      "show_url" => skill_question_path(self.skill, self),
      "size" => read_attribute(:upload_file_size),
      "url" => picture.url,
      "thumbnail_url" => picture.url(:preview),
      "delete_url" => skill_question_path(self.skill, self),
      "delete_type" => "DELETE"
    }
  end
end

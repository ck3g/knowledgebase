class Role
  include Mongoid::Document

  field :name

  embedded_in :user

  ROLES = %w(admin editor)

  validates :name, presence: true, inclusion: { in: ROLES }
end

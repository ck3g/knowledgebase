class InviteCode
  include Mongoid::Document

  field :used, type: Boolean, default: false

  embedded_in :user

  scope :unused, where(used: false)

  def code
    _id.to_s
  end

  def self.codes
    User.all.map(&:invite_codes).flatten.map(&:code)
  end

  def self.unused_codes
    unused_invite_codes = proc { |user| user.invite_codes.unused }
    User.all.map(&unused_invite_codes).flatten.map(&:code)
  end
end

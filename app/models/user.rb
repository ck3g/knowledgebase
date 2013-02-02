class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  field :username
  field :invite_code
  field :invited_by_user_id
  field :need_invitation, type: Boolean, default: true

  embeds_many :invite_codes
  embeds_many :roles

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :invite_code

  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :invite_code, presence: true,
    inclusion: { in: proc { InviteCode.unused_codes }, message: "Invite code is invalid" },
    if: :need_invitation?

  after_create :mark_invite_code_as_used

  Role::ROLES.each do |role|
    define_method "#{role}?" do
      roles.map(&:name).include? role
    end
  end

  private
  def mark_invite_code_as_used
    if invite_code.present?
      invited_by_user = User.where("invite_codes._id" => Moped::BSON::ObjectId(invite_code)).first
      invited_by_user.invite_codes.find(invite_code).update_attributes used: true
      self.invited_by_user_id = invited_by_user.id
      self.save(validate: false)
    end
  end
end

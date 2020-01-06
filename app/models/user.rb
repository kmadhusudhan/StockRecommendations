class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable,
         :session_limitable, :omniauthable, omniauth_providers: [:github]
  has_many :roles
  self.inheritance_column = :gender

  validates :name, presence: true
  validates :dob, presence: true
  validates :email, presence: true

  has_and_belongs_to_many :roles

  after_create :assign_roles

  def self.genders
    %w[Male Female]
   end

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    user = User.find_by_email(auth.info.email)
    unless user.nil?
      user.update(provider: auth.provider, uid: auth.uid, token: auth.credentials.token,
                  expires: auth.credentials.expires, refresh_token: auth.credentials.refresh_token)
    end
    user
    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.token = auth.credentials.token
    #   user.expires = auth.credentials.expires
    #   user.expires_at = auth.credentials.expires_at
    #   user.refresh_token = auth.credentials.refresh_token
    #   user.email = auth.info.email
    #   user.name = auth.info.name
    # end
  end

  def assign_roles
    roles = Role.where.not(name: 'Admin')
    self.roles << roles
  end
end

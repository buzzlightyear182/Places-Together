class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :trips, through: :participation
  has_one :profile

	validates :username, presence: true, length: {maximum: 20}, format: {with: /\A[a-zA-Z0-9]+\z/}
	validates :encrypted_password, presence: true
	validates :email, presence: true, format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}, uniqueness: true

  after_create :create_profile

  private

  def create_profile
    self.profile = Profile.create
  end

end

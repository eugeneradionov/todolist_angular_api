class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
          #:trackable, :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy

  validates :email, presence: true, uniqueness: true, length: { maximum: 63 }
  validate :password_validation

  private

  def password_validation
    if password.present? && !password.match(/^(?=.*[a-zA-Z])(?=.*\d).{8,}$/)
      errors.add :password, 'should be at least 8 characters long, alphanumeric'
    end
  end
end

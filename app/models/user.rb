class User < ApplicationRecord
  has_many :alerts
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end

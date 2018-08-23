class Customer < ActiveRecord::Base
  belongs_to :user
  validates :mac, presence: true
  validates :expired_time, presence: true
  validates :full_name, presence: true
  validates :email, presence: true, format: { with: EMAIL_FORMAT, message: I18n.t("email_validator") }
  validates :phone, presence: true, length: {maximum: 16}
end

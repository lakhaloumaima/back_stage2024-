class User < ApplicationRecord

  has_secure_password
  enum role: [ :superadmin, :admin, :participant ]

  validates_presence_of :email
  validates_uniqueness_of :email

  belongs_to :company, class_name: "Company", foreign_key: "company_id"

  has_many :meetings


end

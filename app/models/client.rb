class Client < ActiveRecord::Base
  include HourlyRateHelper

  include NilStrings

  attr_accessible :name,
    :company_name,
    :zip,
    :street,
    :city,
    :hourly_rate

  belongs_to :user
  has_many :worklogs, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :products, dependent: :destroy  

  validates :user, :name, presence: true
  validates :name, uniqueness: {scope: :user_id, message: "You can only have the client once."}
  validates_numericality_of :hourly_rate, :greater_than => 0, :allow_blank => false

  def string_fields_to_nil
    [:company_name, :zip, :street, :city]
  end

end

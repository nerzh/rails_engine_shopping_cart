class CreditCard < ActiveRecord::Base

  belongs_to :user
  has_many   :orders

  validates :number, :cvv, :exp_month, :exp_year, :first_name, :last_name, presence: true
  validates :cvv,    format: { with: /\A\d{3}\z/ }
  validates :number, format: { with: /\A\d{16}\z/ }
  validates :exp_month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :exp_year,  numericality: { only_integer: true, greater_than_or_equal_to: 2016 }

end

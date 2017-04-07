class Requester < ApplicationRecord

  has_many :sms_messages
  has_many :credit_points

  def total_credit_points
    credit_points.collect(&:points).sum
  end
end

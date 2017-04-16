class CreditPointsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @credit_points = CreditPoint.all
  end
end

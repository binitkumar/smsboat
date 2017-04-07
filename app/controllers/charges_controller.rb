class ChargesController < ApplicationController

  def new
  end

  def preview
  end

  def create
    # Amount in cents
    @amount = params[:amount]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    CreditPoint.create(
      points: (params[:amount].to_i / 50 ),
      requester_id: params[:requester_id]
    )

    redirect_to success_charges_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to preview_charges_path(requester_id: params[:requester_id])
  end

end

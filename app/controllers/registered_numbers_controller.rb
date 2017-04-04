class RegisteredNumbersController < ApplicationController
  before_action :set_registered_number, only: [:show, :edit, :update, :destroy]

  # GET /registered_numbers
  # GET /registered_numbers.json
  def index
    @registered_numbers = RegisteredNumber.all
  end

  # GET /registered_numbers/1
  # GET /registered_numbers/1.json
  def show
  end

  # GET /registered_numbers/new
  def new
    @registered_number = RegisteredNumber.new
  end

  # GET /registered_numbers/1/edit
  def edit
  end

  # POST /registered_numbers
  # POST /registered_numbers.json
  def create
    @registered_number = RegisteredNumber.new(registered_number_params)

    respond_to do |format|
      if @registered_number.save
        format.html { redirect_to @registered_number, notice: 'Registered number was successfully created.' }
        format.json { render :show, status: :created, location: @registered_number }
      else
        format.html { render :new }
        format.json { render json: @registered_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registered_numbers/1
  # PATCH/PUT /registered_numbers/1.json
  def update
    respond_to do |format|
      if @registered_number.update(registered_number_params)
        format.html { redirect_to @registered_number, notice: 'Registered number was successfully updated.' }
        format.json { render :show, status: :ok, location: @registered_number }
      else
        format.html { render :edit }
        format.json { render json: @registered_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registered_numbers/1
  # DELETE /registered_numbers/1.json
  def destroy
    @registered_number.destroy
    respond_to do |format|
      format.html { redirect_to registered_numbers_url, notice: 'Registered number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registered_number
      @registered_number = RegisteredNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registered_number_params
      params.require(:registered_number).permit(:number)
    end
end

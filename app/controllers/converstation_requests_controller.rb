class ConverstationRequestsController < ApplicationController
  before_action :set_converstation_request, only: [:show, :edit, :update, :destroy]

  # GET /converstation_requests
  # GET /converstation_requests.json
  def index
    @converstation_requests = ConverstationRequest.all
  end

  # GET /converstation_requests/1
  # GET /converstation_requests/1.json
  def show
  end

  # GET /converstation_requests/new
  def new
    @converstation_request = ConverstationRequest.new
  end

  # GET /converstation_requests/1/edit
  def edit
  end

  # POST /converstation_requests
  # POST /converstation_requests.json
  def create
    @converstation_request = ConverstationRequest.new(converstation_request_params)

    respond_to do |format|
      if @converstation_request.save
        format.html { redirect_to @converstation_request, notice: 'Converstation request was successfully created.' }
        format.json { render :show, status: :created, location: @converstation_request }
      else
        format.html { render :new }
        format.json { render json: @converstation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /converstation_requests/1
  # PATCH/PUT /converstation_requests/1.json
  def update
    respond_to do |format|
      if @converstation_request.update(converstation_request_params)
        format.html { redirect_to @converstation_request, notice: 'Converstation request was successfully updated.' }
        format.json { render :show, status: :ok, location: @converstation_request }
      else
        format.html { render :edit }
        format.json { render json: @converstation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /converstation_requests/1
  # DELETE /converstation_requests/1.json
  def destroy
    @converstation_request.destroy
    respond_to do |format|
      format.html { redirect_to converstation_requests_url, notice: 'Converstation request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_converstation_request
      @converstation_request = ConverstationRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def converstation_request_params
      params.require(:converstation_request).permit(:requester_id, :exptert_id)
    end
end

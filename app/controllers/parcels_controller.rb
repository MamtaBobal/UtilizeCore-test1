class ParcelsController < ApplicationController
  before_action :set_parcel, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /parcels or /parcels.json
  def index
    if current_user.admin?
      @parcels = Parcel.includes(:sender, :receiver, :service_type)
                     .paginate(page: params[:page], per_page: 10)
    else
      @parcels = Parcel.includes(:sender, :receiver, :service_type)
                       .where(sender_id: current_user.id)
                       .or(Parcel.includes(:sender, :receiver, :service_type)
                       .where(receiver_id: current_user.id))
                       .paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /parcels/1 or /parcels/1.json
  def show
  end

  # GET /parcels/new
  def new
    @parcel = Parcel.new
  end

  # GET /parcels/1/edit
  def edit
  end

  # POST /parcels or /parcels.json
  def create
    @parcel = Parcel.new(parcel_params)

    respond_to do |format|
      if @parcel.save
        format.html { redirect_to @parcel, notice: 'Parcel was successfully created.' }
        format.json { render :show, status: :created, location: @parcel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parcels/1 or /parcels/1.json
  def update
    respond_to do |format|
      if @parcel.update(parcel_params)
        format.html { redirect_to @parcel, notice: 'Parcel was successfully updated.' }
        format.json { render :show, status: :ok, location: @parcel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parcels/1 or /parcels/1.json
  def destroy
    @parcel.destroy
    respond_to do |format|
      format.html { redirect_to parcels_url, notice: 'Parcel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_courier_report
    file_name = 'download_courier_report.xls'
    temporary_file_path = "#{Rails.root}/app/views/parcels/#{file_name}"
    if File.exist?(temporary_file_path)
      file = File.open(temporary_file_path)
      send_data file.read, filename: file_name
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parcel
      @parcel = Parcel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parcel_params
      params.require(:parcel).permit(:weight, :status, :service_type_id,
                                     :payment_mode, :sender_id, :receiver_id,
                                     :cost)
    end
end

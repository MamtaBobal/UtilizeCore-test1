class SearchController < ApplicationController
  def index
    if params[:search].present?
      @parcels = Parcel.where(id: params[:search]).limit(1)
    else
      @parcels = []
    end
  end
end

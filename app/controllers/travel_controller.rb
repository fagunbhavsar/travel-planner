class TravelController < ApplicationController
  def search
    countries = find_country(params[:country])

    unless countries
      flash[:alert] = 'Country not found'
      return render action:index
    end

  def index

  end
end
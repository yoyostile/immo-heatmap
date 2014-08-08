class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.all
  end

  def crawl
    json = Kimono.new.create_apartments
    render json: json
  end

end

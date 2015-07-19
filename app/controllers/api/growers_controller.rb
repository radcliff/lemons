module Api
  class GrowersController < ApplicationController
    def create
      @grower = Grower.create!(grower_params)
      render status: :created if @grower
    end

  private
    def grower_params
      params.require(:grower).permit(:email, :password, :name, :zipcode, :location)
    end
  end
end
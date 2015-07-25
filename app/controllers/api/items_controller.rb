module Api
  class ItemsController < ApplicationController
    def create
      grower = Grower.find(params[:user_id])
      raise ArgumentError, "User not found" if grower.nil?

      @item = Item.new(items_params)

    end

  private
    def items_params
      params.permit(:type, :varietal, :description, :quantity, :unit, :expiration)
    end
  end
end

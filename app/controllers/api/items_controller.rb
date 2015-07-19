module Api
  class ItemsController < ApplicationController
    def create
      grower = Grower.find(params[:user_id])
      raise ArgumentError, "User not found" if grower.nil?

      @item = Item.new(items_params)

      unless list = grower.list
        grower.create_list!(items: [@item.attributes])
      else
        list.items.push(@item.attributes)
        list.save!
      end
    end

  private
    def items_params
      params.permit(:type, :varietal, :description, :quantity, :unit, :expiration)
    end
  end
end

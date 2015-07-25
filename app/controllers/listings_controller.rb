class ListingsController < ApplicationController
  def new
    @kinds = kinds
  end

private
  def kinds
    response = Faraday.get ENV['ITEM_KINDS_URL']
    if response.success?
      JSON.parse(response.body, symbolize_names: true)[:kinds] unless not response.success?
    else
      [ { option: "Lemons", value: "lemons" } ]  # default options
    end 
  end

end

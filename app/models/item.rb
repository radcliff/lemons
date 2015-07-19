class Item
  include ActiveModel::Serializers::JSON
  include ActiveModel::AttributeMethods

  define_attribute_methods :id, :type, :varietal, :description, :quantity, :unit, :expiration

  def initialize(params)
    @id = id

    @type     = params["type"]
    @varietal = params["varietal"]
    @description = params["description"]
    @quantity = params["quantity"].to_i
    @unit     = params["unit"]

    @expiration = expiration
  end

  def attributes
    {
      'id' => @id,
      'type' => @type,
      'varietal' => @varietal,
      'description' => @description,
      'quantity' => @quantity,
      'unit' => @unit,
      'expiration' => @expiration
    }
  end

  def id
    SecureRandom.uuid
  end

  def expiration
    (Time.now + 7.days).at_end_of_day.iso8601
  end

end

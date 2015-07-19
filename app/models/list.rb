class List < ActiveRecord::Base
  belongs_to :grower

  validate :items_schema

private
  def items_schema
    unless JSON::Validator.validate('lib/items-schema.json', items)
      errors.add :items, "are not formatted correctly"
    end
  end

end

class Item < ActiveRecord::Base
  belongs_to :grower

  enum status: [:active, :accepted, :delivered]

  validates_presence_of :kind, :quantity, :unit, :status

end

class PartsOrder < ApplicationRecord
    has_many :parts_order_items, inverse_of: :parts_order
    accepts_nested_attributes_for :parts_order_items
end

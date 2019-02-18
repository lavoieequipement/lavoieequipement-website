class Brand < ApplicationRecord
    has_many :equipments, dependent: :nullify
    has_many :brand_models, inverse_of: :brand, dependent: :destroy

    accepts_nested_attributes_for :brand_models, reject_if: :all_blank, allow_destroy: true
end

class EquipmentType < ApplicationRecord
    has_many :equipments, dependent: :nullify
end

class PowerType < ApplicationRecord
    has_many :equipments, dependent: :nullify
end

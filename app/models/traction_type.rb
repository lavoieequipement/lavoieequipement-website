class TractionType < ApplicationRecord
    has_many :equipments, dependent: :nullify
end

class BrandModel < ApplicationRecord

    belongs_to :brand
    before_destroy :nullify_equipments

    private

    def nullify_equipments
        Equipment.where(brand_model_id: id).update_all(brand_model_id: nil)
    end

end

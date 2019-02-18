module DumbCoder
  extend self

  def load(data)
    data || {}
  end

  def dump(data)
    data || {}
  end
end

class Equipment < ApplicationRecord

    before_save :set_search_terms

    # --------------------------------------------------------------------------

    belongs_to :brand
    belongs_to :brand_model,optional: true
    belongs_to :power_type
    belongs_to :traction_type
    belongs_to :equipment_type

    # --------------------------------------------------------------------------

    has_one_attached :miniature
    has_many_attached :photos

    # --------------------------------------------------------------------------

    typed_store :equipment_attributes, coder: DumbCoder do |p|
        p.string :puissance_cv
    end

    # --------------------------------------------------------------------------

    def self.search(brand,keywords)

        if brand != 0.to_s
            equipments = Equipment.joins(:brand).where("brands.id = ?",brand)
        else
            equipments = Equipment.all
        end
        if keywords.present? && !keywords.nil?  && !keywords.empty?
            equipments = equipments.where("lower(search_terms) like ?","%#{keywords}%")
        end

        equipments

    end

    def set_search_terms
      self.search_terms = [brand.name, brand_model.name, year].reject(&:blank?).join(" ")
    end

end

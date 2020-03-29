# frozen_string_literal: true

# Foodbank, associated to many pantries
class Foodbank < ApplicationRecord
  self.table_name = 'foodbanks_mini'

  alias_attribute :id, :fb_id


  has_many :foodbank_counties, foreign_key: :fb_id, inverse_of: :foodbank
  has_many :counties, through: :foodbank_counties
  has_many :agencies, foreign_key: :primary_fb_id, inverse_of: :foodbank

 
  scope :serving_county, -> (zip_code) {
    joins(counties: :zip_codes)
      .where(counties: { zip_codes: { zip_code: zip_code } })
      .active
  }
  scope :active, -> { where(status_id: 1) }
  
end

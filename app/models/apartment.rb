class Apartment < ActiveRecord::Base

  validates_uniqueness_of :is24_id

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  scope :with_coordinates, -> { where.not(latitude: nil).where.not(longitude: nil) }

  def address
    address = self.read_attribute(:address).match(/(.*\d),.*,(.*)/)
    address && address.length == 3 ? [ address[1], '50674', address[2] ].join(',') : nil
  end

  def street
    address.match(/(\A[^,][^\d*]*)/)[0].gsub('Straße','str').strip.gsub(' ','_').gsub('.','').downcase if address
  end

  def sq_rent
    rent / size.to_f
  end
end

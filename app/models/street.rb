class Street

  def self.get_avg_street_rent
    res = {}
    Apartment.with_coordinates.group_by(&:street).each do |k,v|
      res[k] = {
        rent: v.sum { |a| a.sq_rent } / v.length,
        apartments_count: v.length
      }
    end
    res
  end

end

class Place < OpenStruct
  def self.rendered_fields
    [:id, :status, :street, :city, :zip, :country, :overall]
  end    
end    
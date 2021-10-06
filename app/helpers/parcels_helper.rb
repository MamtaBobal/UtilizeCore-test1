module ParcelsHelper
  def users
    User.includes(:address).all.map{|user| [user.name_with_address, user.id]}
  end

  def service_types
    ServiceType.all.map{|service_type| [service_type.name, service_type.id]}
  end
end

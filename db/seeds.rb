# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Speed Post', 'Regular'].each do |name|
	ServiceType.create(name: name)
end


['sender', 'receiver'].each do |name|
	user = User.new(name: name, email: "#{name}@gmail.com", password: "#{name}")
	user.build_address(address_line_one: "Test Street #{name}", city: "New Delhi",
		               state: "New Delhi", country: "India", pincode: 110111,
		               mobile_number: '9999999999')
	user.save
end

# Add Admin User
admin_user = User.create(name: "admin", email: "admin@gmail.com", password: "adminuser", admin: true)
admin_user.create_address(address_line_one: "Admin Street", city: "New Delhi",
	                       state: "New Delhi", country: "India", pincode: 110111,
	                        mobile_number: '9999999999')

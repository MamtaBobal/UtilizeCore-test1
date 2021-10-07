class Parcel < ApplicationRecord

	STATUS = ['Sent', 'In Transit', 'Delivered']
	PAYMENT_MODE = ['COD', 'Prepaid']

	validates :weight, :status, presence: true
	validates :status, inclusion: STATUS
	validates :payment_mode, inclusion: PAYMENT_MODE

	belongs_to :service_type
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	after_commit :send_notification, on: :create
	after_commit :status_change_email, on: :update

	private

	def send_notification
		UserMailer.with(parcel: self).status_email.deliver_later
	end

	def status_change_email
		if saved_change_to_status?
			UserMailer.with(parcel: self).status_change_email.deliver_later
		end
	end

end

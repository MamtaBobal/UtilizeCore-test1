# frozen_string_literal: true

namespace :report do
  desc 'Export Report in XLS format'
  task courier_report: :environment do
    File.open("#{Rails.root.join('app/views/parcels/download_courier_report')}.xls", 'w') do |file|
      file.write(ActionController::Base.new.render_to_string(
                   template: 'parcels/couriers_report_template.xlsx.axlsx',
                   layout: false,
                   formats: [:xlsx],
                   locals: { parcels: Parcel.includes(:sender, :receiver, :service_type)
                                           .where(created_at: (Date.today - 1).beginning_of_day..(Date.today - 1).end_of_day) }
                 ))
    end
  end
end

class Hospital < ApplicationRecord
  has_many :doctors

  def get_doctors
    doctors.select('doctors.*, count(patients.id) as patient_count').joins(:patients).group('doctors.id')
    .order(patient_count: :desc)
  end
end

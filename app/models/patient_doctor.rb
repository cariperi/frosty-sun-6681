class PatientDoctor < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  def self.get_record(patient_id, doctor_id)
    where(["patient_id = ? AND doctor_id = ?", patient_id, doctor_id]).first
  end
end

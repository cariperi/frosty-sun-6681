require 'rails_helper'

RSpec.describe PatientDoctor, type: :model do
  describe "relationships" do
    it {should belong_to :patient}
    it {should belong_to :doctor}
  end

  describe "class methods" do
    before(:each) do
      @hospital_1 = Hospital.create!(name: "Hospital 1")
      @hospital_2 = Hospital.create!(name: "Hospital 2")

      @doctor_1 = @hospital_1.doctors.create!(name: "Doctor 1", specialty: "internal", university: "ABC")
      @doctor_2 = @hospital_1.doctors.create!(name: "Doctor 2", specialty: "surgery", university: "DEF")

      @doctor_3 = @hospital_2.doctors.create!(name: "Doctor 3", specialty: "cardio", university: "GHI")
      @doctor_4 = @hospital_2.doctors.create!(name: "Doctor 4", specialty: "oncology", university: "JKL")

      @patient_1 = Patient.create!(patient_name: "Patient 1", age: 35)
      @patient_2 = Patient.create!(patient_name: "Patient 2", age: 17)
      @patient_3 = Patient.create!(patient_name: "Patient 3", age: 28)

      @patient_doctor_1 = PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_1.id)
    end

    describe 'get_record(patient_id, doctor_id)' do
      it 'gets the patient doctor record for the given patient id and doctor id' do
        expect(PatientDoctor.get_record(@patient_1.id, @doctor_1.id)).to eq(@patient_doctor_1)
      end
    end
  end
end

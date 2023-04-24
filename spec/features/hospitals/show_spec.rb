require 'rails_helper'

RSpec.describe 'the hospital show page' do
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
    @patient_4 = Patient.create!(patient_name: "Patient 4", age: 19)

    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_2.id)
    PatientDoctor.create!(patient_id: @patient_3.id, doctor_id: @doctor_2.id)
    PatientDoctor.create!(patient_id: @patient_4.id, doctor_id: @doctor_2.id)

    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_3.id)
    PatientDoctor.create!(patient_id: @patient_3.id, doctor_id: @doctor_4.id)
  end

  describe 'Extension' do
    it 'shows the hospitals name' do
      visit hospital_path(@hospital_1)
      expect(page).to have_content("Name: #{@hospital_1.name}")
      expect(page).to_not have_content("Name: #{@hospital_2.name}")
    end

    it 'shows the names of all doctors at the hospital with their number of patients ordered from most patients to least' do
      visit hospital_path(@hospital_1)

      expect(page).to have_content("Doctor: #{@doctor_2.name} - Patient Count: 3")
      expect(page).to have_content("Doctor: #{@doctor_1.name} - Patient Count: 2")

      expect(@doctor_2.name).to appear_before(@doctor_1.name)

      expect(page).to_not have_content(@doctor_3.name)
      expect(page).to_not have_content(@doctor_4.name)
    end
  end
end

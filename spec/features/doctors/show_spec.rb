require 'rails_helper'

RSpec.describe 'the doctors show page' do
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

    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_3.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_2.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_3.id, doctor_id: @doctor_4.id)
  end

  describe 'User Story 1' do
    it 'should display the name, speciality, and university for this doctor' do
      visit doctor_path(@doctor_1)

      expect(page).to have_content("Doctor Name: #{@doctor_1.name}")
      expect(page).to have_content("Specialty: #{@doctor_1.specialty}")
      expect(page).to have_content("Graduated From: #{@doctor_1.university}")

      expect(page).to_not have_content("Doctor Name: #{@doctor_2.name}")
      expect(page).to_not have_content("Specialty: #{@doctor_2.specialty}")
      expect(page).to_not have_content("Graduated From: #{@doctor_2.university}")
    end

    it 'should display the name of the hospital where this doctor works' do
      visit doctor_path(@doctor_1)

      expect(page).to have_content("Hospital Affiliation: #{@hospital_1.name}")
      expect(page).to_not have_content("Hospital Affiliation: #{@hospital_2.name}")
    end

    it 'should see the names of all the patients this doctor has' do
      visit doctor_path(@doctor_1)

      expect(page).to have_content("Patients Affiliated With This Doctor:")

      within("#patient-#{@patient_1.id}") do
        expect(page).to have_content("Patient Name: #{@patient_1.patient_name}")
      end

      within("#patient-#{@patient_2.id}") do
        expect(page).to have_content("Patient Name: #{@patient_2.patient_name}")
      end

      expect(page).to_not have_content("Patient Name: #{@patient_3.patient_name}")
    end
  end
end




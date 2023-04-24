require 'rails_helper'

RSpec.describe 'the patient index page' do
  before(:each) do
    @hospital_1 = Hospital.create!(name: "Hospital 1")
    @hospital_2 = Hospital.create!(name: "Hospital 2")

    @doctor_1 = @hospital_1.doctors.create!(name: "Doctor 1", specialty: "internal", university: "ABC")
    @doctor_2 = @hospital_1.doctors.create!(name: "Doctor 2", specialty: "surgery", university: "DEF")

    @doctor_3 = @hospital_2.doctors.create!(name: "Doctor 3", specialty: "cardio", university: "GHI")
    @doctor_4 = @hospital_2.doctors.create!(name: "Doctor 4", specialty: "oncology", university: "JKL")

    @patient_1 = Patient.create!(patient_name: "Bob", age: 35) #should be second
    @patient_2 = Patient.create!(patient_name: "Jane", age: 17)
    @patient_3 = Patient.create!(patient_name: "Alex", age: 28) #should be first
    @patient_4 = Patient.create!(patient_name: "John", age: 18)
    @patient_5 = Patient.create!(patient_name: "Carol", age: 50) #should be third

    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_3.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_2.id)
    PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_1.id)
    PatientDoctor.create!(patient_id: @patient_3.id, doctor_id: @doctor_4.id)
  end

  describe 'User Story 3' do
    it 'displays the names of all adult patients with an age over 18' do
      visit patients_path
      expect(page).to have_content(@patient_1.patient_name)
      expect(page).to have_content(@patient_3.patient_name)
      expect(page).to have_content(@patient_5.patient_name)

      expect(page).to_not have_content(@patient_2.patient_name)
      expect(page).to_not have_content(@patient_4.patient_name)
    end

    it 'displays names in ascending alphabetical order' do
      visit patients_path

      expect(@patient_3.patient_name).to appear_before(@patient_1.patient_name)
      expect(@patient_1.patient_name).to appear_before(@patient_5.patient_name)
      expect(@patient_5.patient_name).to_not appear_before(@patient_3.patient_name)
    end
  end
end

require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'relationships' do
    it {should have_many :patient_doctors}
    it {should have_many(:doctors).through(:patient_doctors)}
  end

  describe 'class methods' do
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
    end

    describe '.adult_patients_ordered' do
      it 'returns an array of patients over 18 ordered by name A to Z ascending' do
        expect(Patient.adult_patients_ordered).to eq([@patient_3, @patient_1, @patient_5])
        expect(Patient.adult_patients_ordered).to_not include(@patient_2)
        expect(Patient.adult_patients_ordered).to_not include(@patient_4)
      end
    end
  end
end
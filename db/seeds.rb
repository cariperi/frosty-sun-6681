# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.destroy_all
Patient.destroy_all
PatientDoctor.destroy_all
Hospital.destroy_all

@hospital_1 = Hospital.create!(name: "Hospital 1")
@hospital_2 = Hospital.create!(name: "Hospital 2")

@doctor_1 = @hospital_1.doctors.create!(name: "Doctor 1", specialty: "internal", university: "ABC")
@doctor_2 = @hospital_1.doctors.create!(name: "Doctor 1", specialty: "surgery", university: "DEF")

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

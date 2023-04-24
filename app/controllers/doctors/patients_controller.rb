class Doctors::PatientsController < ApplicationController
  def destroy
    patient_doctor = PatientDoctor.get_record(params[:id], params[:doctor_id])
    patient_doctor.destroy
    redirect_to doctor_path(params[:doctor_id])
  end
end
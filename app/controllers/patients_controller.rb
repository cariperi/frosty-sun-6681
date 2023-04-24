class PatientsController < ApplicationController
  def index
    @patients = Patient.adult_patients_ordered
  end
end

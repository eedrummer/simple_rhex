require 'belongs_to_patient'

class AuthorizedUsersController < ApplicationController
  include BelongsToPatient
  
  def create
    au = AuthorizedUser.new(params[:authorized_user])
    au.patient = @patient
    if au.save
      render :partial => 'shared/authorized_user', :collection => @patient.authorized_users
    else
      render :json => au.errors, :status => 400
    end
  end

  def destroy
    au = @patient.authorized_users.find(params[:id])
    au.destroy
    redirect_to patient_url(@patient)
  end
end

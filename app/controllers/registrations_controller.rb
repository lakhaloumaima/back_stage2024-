class RegistrationsController < ApplicationController

  # create admin
  def createAdmin
    @current_user = User.find( session[:user_id] )

    if @current_user.role == "superadmin"
      company = Company.new(company_params)
      admin = User.new(admin_params.merge( role: 1 ))

      if company.save
        admin.company = company
        if admin.save
          UserMailer.registration_confirmation( admin ).deliver
          render json: { status: :created, company: company, admin: admin }
        else
          company.destroy # Rollback company creation if admin creation fails
          render json: { status: :unprocessable_entity, errors: admin.errors.full_messages }
        end
      else
        render json: { status: :unprocessable_entity, errors: company.errors.full_messages }
      end
    else
      render json: { status: :unprocessable_entity, errors: "You don't have access, must be an superadmin" }
    end
  end

  # create superadmin
  def createSuperAdmin
    superadmin = User.new(superadmin_params.merge( role: 0, company_id: 1 ))

    if user.save
      UserMailer.registration_confirmation( superadmin ).deliver
      render json: { status: :created, superadmin: superadmin }
    else
      render json: { status: :unprocessable_entity, errors: superadmin.errors.full_messages }
    end
  end

  # create participant
  def createParticipant
    @current_user = User.find(session[:user_id])

    if @current_user.role == "admin"
      participant = User.new( participant_params.merge( role: 2, company_id: @current_user.company_id ) )

      if participant.save
        UserMailer.registration_confirmation( participant ).deliver
        render json: { status: :created, participant: participant }
      else
        render json: { status: :unprocessable_entity, errors: participant.errors.full_messages }
      end
    else
      render json: { status: :unprocessable_entity, errors: "You don't have access, must be an admin" }
    end

  end

  private

  def superadmin_params
    params.require(:user).permit(:email, :password, :password_confirmation )
  end

  def company_params
    params.require(:company).permit(:name, :subdomain )
  end

  def admin_params
    params.require(:user).permit(:email, :password, :password_confirmation )
  end

  def participant_params
    params.require(:user).permit( :email, :password, :password_confirmation )
  end

end

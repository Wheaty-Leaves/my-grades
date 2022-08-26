# frozen_string_literal: true

class Teachers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params


  # GET /resource/sign_up
  #def new
  #   super
  #end

  # POST /resource
  # def create
  #   @teacher = Teacher.new(teacher_params)
  #
  #   respond_to do |format|
  #     if @teacher.save
  #       format.html { redirect_to root_path, notice: "Teacher was successfully created." }
  #       format.json { render :show, status: :created, location: @voter }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @teacher.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uniID])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uniID])
  # end

  # def teacher_params
  #   params.require(:teacher).permit(:id,:first_name, :last_name, :uniID, :email, :password, :password_confirmation)
  # end

  # The path used after sign up.
  #def after_sign_up_path_for(_resource)
  #root_path
  #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

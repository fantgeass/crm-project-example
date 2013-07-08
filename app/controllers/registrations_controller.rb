class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id).decorate
    if @user.update_without_password(params[:user])
      set_flash_message :notice, :updated
      #redirect_to after_update_path_for(@user)
      render 'edit'
    else
      render 'edit'
    end
  end
end
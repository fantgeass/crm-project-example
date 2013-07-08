class UsersController < ResourceController
  respond_to :json


  def form
    @user = User.new
    render partial: 'form'
  end

end
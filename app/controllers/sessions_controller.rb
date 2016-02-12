class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.html { 
        super
      }
      format.json {
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :json => { :status => :ok, :authentication_token => current_user.authentication_token }
      }
    end
  end

  def failure
    render :json => { :success => false, :error => t('devise.failure.invalid') }, status: :unauthorized
  end

end
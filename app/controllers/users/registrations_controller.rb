class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def show
    user = current_user
    if user 
      render json: { first_name: user.first_name, last_name: user.last_name, email: user.email }, status: :ok
    else
      render json: { error: "User not found." }, status: :not_found
    end
  end
  
  def update
    user = current_user
    user.first_name = params[:first_name] if params[:first_name].present?
    user.last_name = params[:last_name] if params[:last_name].present?
    user.image = params[:image] if params[:image].present?
    
    if user.save
      render json: {
        status: { code: 200, message: 'user updated successfully', data: user }
      }, status: :ok
    else
      render json: {
        status: { message: 'user could not be updated', errors: user.errors.full_messages },
        status: :unprocessable_entity
      }
    end
  end

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'signed in successfully', data: resource }
      }, status: :ok
    else
      render json: {
        status: { message: 'User could not be created successfully', errors: resource.errors.full_messages },
        status: :unprocessable_entity
      }
    end
  end
end

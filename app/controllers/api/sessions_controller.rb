module Api
  class SessionsController < ApplicationController
    def create  # http://pivotallabs.com/playing-with-ember-js-and-devise/
      grower = Grower.find_for_database_authentication(email: session_params[:email])

      if grower && grower.valid_password?(session_params[:password])
        sign_in grower
        render json: {
          session: { id: grower.id, email: grower.email }
        }, status: :created
      else
        render json: {
          errors: {
            email: "invalid email or password"
          }
        }, status: :unprocessable_entity
      end
    end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

    # def destroy
    #   sign_out :grower
    #   render json: {}, status: :accepted
    # end

  end
end

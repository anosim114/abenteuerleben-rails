module Parent
    class LocationsController < ApplicationController
        def new
            @parent_location = Location.new
        end

        def create
            @parent_location = Location.new parent_location_params

            if @parent_location.valid?
                session[:parent_location] = {
                    street: @parent_location.street,
                    house: @parent_location.house,
                    post: @parent_location.post,
                    city: @parent_location.city
                }

                redirect_to new_parent_child_path
            else
                render :new, status: :unprocessable_entity
            end
        end

        private

        def parent_location_params
            params.require(:parent_location).permit(
                :street,
                :house,
                :post,
                :city
            )
        end
    end
end

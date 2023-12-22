module Parent
    class ChildrenController < ApplicationController
        def new
            # TODO: more like: 'ChildStat' instead of 'Child'
            @parent_children = Child.new
        end

        def create
            @parent_children = Child.new parent_child_params

            if @parent_children.valid?
                session[:parent_children] = {
                    count: @parent_children.count
                }

                redirect_to new_child_path
            else
                render :new, status: :unprocessable_entity
            end
        end

        private

        def parent_child_params
            params.require(:parent_child).permit(
                :count
            )
        end
    end
end

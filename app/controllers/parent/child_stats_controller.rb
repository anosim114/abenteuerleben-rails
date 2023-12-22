module Parent
    class ChildStatsController < ApplicationController
        def new
            previous_params = session[:parent_child_stat] if !session[:parent_child_stat].nil?
            @parent_child_stat = ChildStat.new previous_params
        end

        def create
            @parent_child_stat = ChildStat.new parent_child_stat_params
            logger.debug @parent_child_stat

            if @parent_child_stat.valid?
                session[:parent_child_stat] = {
                    count: @parent_child_stat.count
                }

                redirect_to new_child_path
            else
                render :new, status: :unprocessable_entity
            end
        end

        private

        def parent_child_stat_params
            params.require(:parent_child_stat).permit(
                :count
            )
        end
    end
end

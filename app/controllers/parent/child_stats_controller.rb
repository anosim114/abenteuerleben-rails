module Parent
  class ChildStatsController < ApplicationController
    def new
      previous_params = session[:parent_child_stat] unless session[:parent_child_stat].nil?
      @parent_child_stat = ChildStat.new previous_params
    end

    def create
      @parent_child_stat = ChildStat.new parent_child_stat_params

      if @parent_child_stat.valid?
        session[:parent_child_stat] = {
          count: @parent_child_stat.count
        }
        logger.debug session[:parent_child_stat]

        skip_children = !session[:children].nil? && session[:children].length >= @parent_child_stat.count.to_i
        redirect_to skip_children ? new_parent_parent_path : new_child_path(child_num: 0)
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

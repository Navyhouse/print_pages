class ApplicationController < ActionController::Base
    before_action :set_search

    def set_search
      @q = Question.ransack(params[:q])
      @question = @q.result(distinct: true).page(params[:page]).per(10) 
    end

end

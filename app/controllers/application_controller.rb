class ApplicationController < ActionController::Base
    before_action :set_search

    def set_search
      @q = Question.search(params[:q])
      @question = @q.result(distinct: true).page(params[:page]).per(10) 

      # @q = Question.ransack(params[:q])
      # @question = @q.result

      #@q = Question.ransack(params[:q]) #ransackメソッド推奨
      #@question = @q.result.includes(:question).page(params[:page]) # 検索結果(検索しなければ全件取得)
    end

end

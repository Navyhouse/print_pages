class ApplicationController < ActionController::Base
    before_action :set_search

    def set_search
      #@search = Article.search(params[:q])
      #@search_question = @search.result

      @q = Question.ransack(params[:q]) #ransackメソッド推奨
      @question = @q.result.includes(:question).page(params[:page]) # 検索結果(検索しなければ全件取得)
    end

end

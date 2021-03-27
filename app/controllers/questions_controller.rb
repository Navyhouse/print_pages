class QuestionsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]
    impressionist :actions=> [:show]
    respond_to :js

    def index
        @test = "Welcome PrintPages!!" 
        @q = Question.search(params[:q])
        @question = @q.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(15)
        # @question_sec = @q.result(distinct: true).order(answer: "DESC").page(params[:page]).per(15) 
        @users= User.all
        @random = Question.order("RANDOM()").limit(1)
    end

    def cautions
    end
    
    def show
        @question = Question.find(params[:id])
        impressionist(@question, nil, unique: [:session_hash])
        @answer = Answer.new
        @like = Like.new
    end
    
    def new
        @question = Question.new
    end

    def create
        @question = Question.new(question_params)
        @question.user_id = current_user.id
        if @question.save
          flash[:notice] = "質問は投稿されました。回答が届くまでお待ちください。"
          redirect_to("/questions/new")
        else
          flash.now[:alert] = "エラー！内容確認して再度投稿してください。"
           render("questions/new")
        end
    end

    def edit
        @question = Question.find(params[:id])
    end
    
    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
          flash[:notice] = "成功！"
          redirect_to("/questions/#{@question.id}")
        else
          flash.now[:alert] = "失敗！"
          render("questions/edit")
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        flash[:notice] = "成功！"
        redirect_to("/questions")
    end

  private
    def question_params
      params.require(:question).permit(:title, :body, :tag_list, :image, :finished)
    end
    
    def ensure_correct_user
        @question = Question.find_by(id: params[:id])
        if @question.user_id != current_user.id
          flash[:alert] = "権限がありません"
          redirect_to("/questions/#{@question.id}")
        end
    end
    
end

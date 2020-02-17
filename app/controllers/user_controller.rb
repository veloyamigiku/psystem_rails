class UserController < ApplicationController

    def register
        # リクエストパラメータから、利用者登録情報を取得する。
        user = params[:user]
        password = params[:password]
        username = params[:username]

        # 利用者登録結果を送信する。
        registerResult = RegisterResult.new(true)
        render json: sample.toHash
        
    end
    
end

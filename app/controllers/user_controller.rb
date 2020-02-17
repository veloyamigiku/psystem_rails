class UserController < ApplicationController

    def token
        t = form_authenticity_token
        render json: {"token" => t}
    end

    def register
        # リクエストパラメータから、利用者登録情報を取得する。
        user = params[:user]
        password = params[:password]
        username = params[:username]

        # 利用者登録結果を送信する。
        registerResult = RegisterResult.new(true)
        render json: registerResult.toHash

    end
    
end

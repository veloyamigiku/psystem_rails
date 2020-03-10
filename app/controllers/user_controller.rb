class UserController < ApplicationController

    def token
        t = form_authenticity_token
        render json: {"token" => t}
    end

    def register
        # リクエストパラメータから、利用者登録情報を取得する。
        name = params[:name]
        password = params[:password]
        username = params[:username]

        # 利用者を登録する。
        newUser = User.new
        newUser.name = name
        newUser.password = password
        newUser.username = username
        registerResult = nil
        if newUser.save
            registerResult = RegisterResult.new(true)
        else
            registerResult = RegisterResult.new(false)
        end

        # 利用者登録結果を送信する。
        render json: registerResult.toHash

    end
    
end

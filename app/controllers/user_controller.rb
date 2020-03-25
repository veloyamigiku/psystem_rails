class UserController < ApplicationController

    def issue_token_for_register
        # 利用者登録用のJWTトークンの有効期限を15分とする。
        t = Auth.issueJwt(15)
        render json: {"token" => t}
    end

    def register
        registerResult = RegisterResult.new(false)

        # リクエストパラメータから、利用者登録情報を取得する。
        name = params[:name]
        password = params[:password]
        username = params[:username]

        # JWTトークンを検証する。
        token = request.headers["Authorization"]
        result = Auth.verifyJwt(token)
        if result.nil?
            render json: registerResult.toHash
            return
        end

        # パスワードをハッシュ化する。
        password_hash = PasswordHash.md5(password)

        # 利用者を登録する。
        newUser = User.new
        newUser.name = name
        newUser.password = password_hash
        newUser.username = username
        
        if newUser.save
            registerResult.result = true
        end

        # 利用者登録結果を送信する。
        render json: registerResult.toHash

    end
    
end

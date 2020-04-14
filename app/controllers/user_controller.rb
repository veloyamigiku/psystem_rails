class UserController < ApplicationController

    def issue_register_token

        rtIssueToken = ResultType::RtIssueRegisterTokenForUser.new()

        # 利用者登録用のJWTトークンの有効期限を15分とする。
        t = Auth::Jwt.issueJwt(15)
        rtIssueToken.result = true
        rtIssueToken.token = t
        render json: rtIssueToken.toHash

    end

    def issue_login_token

        rtIssueToken = ResultType::RtIssueLoginTokenForUser.new()
        
        # ログイン用のJWTトークンの有効期限を15分とする。
        t = Auth::Jwt.issueJwt(15)
        rtIssueToken.result = true
        rtIssueToken.token = t
        render json: rtIssueToken.toHash

    end

    def register
        registerResult = ResultType::RtRegister.new(false)

        # リクエストパラメータから、利用者登録情報を取得する。
        name = params[:name]
        password = params[:password]
        username = params[:username]

        # JWTトークンを検証する。
        token = request.headers["Authorization"]
        result = Auth::Jwt.verifyJwt(token)
        if result.nil?
            render json: registerResult.toHash
            return
        end

        # パスワードをハッシュ化する。
        password_hash = Auth::PasswordHash.md5(password)

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

    def login

        resultLogin = ResultType::RtLogin.new(false, nil)

        # JWTトークンを検証する。
        token = request.headers["Authorization"]
        result = Auth::Jwt.verifyJwt(token)
        if result.nil?
            render json: resultLogin.toHash
            return
        end

        # リクエストパラメータを取得する。
        param_name = params[:name]
        param_password = params[:password]

        # ユーザを検索する。
        user = User.find_by(name: param_name)
        if user == nil
            render json: resultLogin.toHash
            return
        end

        # リクエストパラメータのパスワードをハッシュ化する。
        param_password_hash = Auth::PasswordHash.md5(param_password)

        # パスワードハッシュを比較する。
        if user.password != param_password_hash
            render json: resultLogin.toHash
            return
        end

        # JWTトークンを発行する。
        resultLogin.token = Auth::Jwt.issueJwt(30)
        resultLogin.result = true
        
        render json: resultLogin.toHash

    end
    
end

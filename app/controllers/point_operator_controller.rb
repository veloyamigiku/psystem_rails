class PointOperatorController < ApplicationController

    # ポイント操作元の登録用トークンを発行する。
    def issue_register_token
        
        result = ResultType::RtIssueRegisterTokenForPointOperator.new()
        result.result = false

        
        token = Auth::Jwt.issueJwt(15)
        result.result = true
        result.token = token

        render json: result.toHash

    end

    # ポイント操作元を登録する。
    def register
        
        result = ResultType::RtRegisterForPointOperator.new(false)

        token = request.headers["Authorization"]
        if Auth::Jwt.verifyJwt(token).nil?
            render json: result.toHash
            return
        end

        newPointOperator = PointOperator.new
        newPointOperator.name = params[:name]
        newPointOperator.password = Auth::PasswordHash.md5(params[:password])
        if newPointOperator.save
            result.result = true
        end

        render json: result.toHash

    end

    # ポイント操作元のログイン用トークンを発行する。
    def issue_login_token

        result = ResultType::RtIssueLoginTokenForPointOperator.new
        result.result = false

        token = Auth::Jwt.issueJwt(15)
        result.token = token
        result.result = true

        render json: result.toHash
        
    end

    # ポイント操作元のログインをする。
    def login

        res = ResultType::RtLoginForPointOperator.new(false, nil)

        token = request.headers["Authorization"]
        if Auth::Jwt.verifyJwt(token).nil?
            render json: res.toHash
            return
        end

        paramName = params[:name]
        paramPassword = params[:password]
        paramHashedPassword = Auth::PasswordHash.md5(paramPassword)
        pointOperator = PointOperator.find_by(name: paramName, password: paramHashedPassword)
        if pointOperator == nil
            render json: res.toHash
            return
        end

        newToken = Auth::Jwt.issueJwtAfterLogin(30, pointOperator.name)
        res.result = true
        res.token = newToken

        render json: res.toHash
    end

    # ポイント操作履歴を保存する。
    def add_point_history

        res = ResultType::RtAddPointHistory.new()
        res.result = false

        token = request.headers["Authorization"]
        decode = Auth::Jwt.verifyJwt(token)
        if decode.nil?
            render json: res.toHash
            return
        end
        claims = decode[0]

        name = claims["name"]
        pointOperator = PointOperator.find_by(name: name)
        if pointOperator.nil?
            render json: res.toHash
            return
        end

        # save point history

        res.result = true
        res.count = 0

        render json: res.toHash

    end

end

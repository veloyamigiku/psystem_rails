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
    #def issue_login_token
    #end

    # ポイント操作元のログインをする。
    #def login
    #end

end

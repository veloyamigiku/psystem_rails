class UserController < ApplicationController

    def register
        sample = RegisterResult.new(true)
        render json: sample.toHash
    end
    
end

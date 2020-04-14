module ResultType

    class RtLoginForUser < RtBase

        attr_accessor :result, :token

        def initialize(result, token)
            @result = result
            @token = token
        end

    end

end

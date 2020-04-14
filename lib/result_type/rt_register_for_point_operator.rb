module ResultType
    class RtRegisterForPointOperator < RtBase
        attr_accessor :result
        def initialize(result)
            @result = result
        end
    end
end

module ResultType
    class RtBase

        def initialize()    
        end

        def toHash()
            self
                .instance_variables
                .map { |sym| [sym.id2name.gsub(/@/, ""), self.instance_variable_get(sym)]}
                .to_h
        end
        
    end
end

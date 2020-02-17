class RegisterResult

    def initialize(result)
        @result = result
    end

    def toHash()
        self
            .instance_variables
            .map { |sym| [sym.id2name.gsub(/@/, ""), self.instance_variable_get(sym)] }
            .to_h
    end

end

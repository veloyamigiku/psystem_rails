require 'digest'

module Auth
    class PasswordHash

        def self.md5(password)
            Digest::MD5.hexdigest(password)
        end

    end
end

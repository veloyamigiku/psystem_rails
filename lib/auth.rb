require 'jwt'
require 'openssl'

class Auth

    def self.issueJwt(exp_minutes = 1)
        rsa_private = OpenSSL::PKey::RSA.new(ENV["PSYSTEM_RSA"])
        payload = {
            data: 'test',
            exp: (Time.now + exp_minutes.minutes).to_i
        }
        token = JWT.encode(payload, rsa_private, 'RS256')
        return token
    end

    def self.verifyJwt(token)
        rsa_private = OpenSSL::PKey::RSA.new(ENV["PSYSTEM_RSA"])
        rsa_public = rsa_private.public_key
        result = nil
        begin
            result = JWT.decode(token, rsa_public, true, {algorithm: 'RS256'})
        rescue => e
            p e
        end
        return result
    end

end

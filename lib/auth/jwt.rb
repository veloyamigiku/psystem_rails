require 'jwt'
require 'openssl'

module Auth
    class Jwt

        def self.issueJwt(exp_minutes = 1)
            rsa_private = self.readPrivateKey
            payload = {
                data: 'test',
                exp: (Time.now + exp_minutes.minutes).to_i
            }
            token = JWT.encode(payload, rsa_private, 'RS256')
            return token
        end

        def self.issueJwtAfterLogin(exp_minutes = 1, name)
            rsa_private = self.readPrivateKey
            payload = {
                name: name,
                exp: (Time.now + exp_minutes.minutes).to_i
            }
            token = JWT.encode(payload, rsa_private, 'RS256')
            return token
        end

        def self.verifyJwt(token)
            rsa_public = self.readPublicKey
            result = nil
            begin
                result = JWT.decode(token, rsa_public, true, {algorithm: 'RS256'})
            rescue => e
                p e
            end
            return result
        end

        private

        def self.readPrivateKey()
            OpenSSL::PKey::RSA.new(ENV["PSYSTEM_RSA"])
        end

        def self.readPublicKey()
            rsa_private = self.readPrivateKey
            rsa_private.public_key
        end

    end
end

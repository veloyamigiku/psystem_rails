# create key
# openssl genrsa 2048 > server.key
# create csr
# openssl req -new -key server.key > server.csr
# create crt
# openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt
if 'development' == ENV.fetch('RAILS_ENV') { 'development' }
    ssl_bind '0.0.0.0', '443', {
        key: 'server.key',
        cert: 'server.crt',
        verify_mode: "none"
    }
end

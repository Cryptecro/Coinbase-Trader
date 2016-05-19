require 'base64'
require 'openssl'
require 'json'

class CoinbaseExchange
    def initialize(key, secret, passphrase)
      @key = key
      @secret = secret
      @passphrase = passphrase
    end

    def signature(request_path='', body='', timestamp=nil, method='GET')
      body = body.to_json if body.is_a?(Hash)
      timestamp = Time.now.to_i if !timestamp

      what = "#{timestamp}#{method}#{request_path}#{body}";

      # create a sha256 hmac with the secret
      secret = Base64.decode64(@secret)
      hash  = OpenSSL::HMAC.digest('sha256', secret, what)
      Base64.strict_encode64(hash)
      
    
    end
end

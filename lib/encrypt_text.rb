require 'openssl'

module EncryptText
  
  KEY = ENV["message_key"]
  ALGORITHM = ENV["algorithm"]

  def self.encrypt(message)
    # SecureRandom.random_bytes(16)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt()
    cipher.key = KEY
    crypt = cipher.update(message) + cipher.final()
    crypt_string = (Base64.encode64(crypt))
    return crypt_string
  end

  def self.decrypt(message)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.decrypt()
    cipher.key = KEY
    tempkey = Base64.decode64(message)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
  end


end

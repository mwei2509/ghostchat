require 'openssl'
require 'bcrypt'

module EncryptText
  KEY = ENV["message_key"]
  KEY32 = ENV["message_key_32"]
  ALGORITHM = 'AES-256-CBC'
  #ALGORITHM = ENV["algorithm"]

  def self.encrypt(message, password, iv)
    # SecureRandom.random_bytes(16)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt()
    cipher.key = self.digest_password(password)
    cipher.iv = iv
    crypt = cipher.update(message) + cipher.final()
    crypt_string = (Base64.encode64(crypt))
    return crypt_string
  end

# returns encrypted key to store in user's sessions
  def self.encrypt_key(key)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt()
    cipher.key=KEY32
    crypt = cipher.update(key) + cipher.final()
    crypt_string = (Base64.encode64(crypt))
    return crypt_string
  end

# decrypts key to be used
  def self.decrypt_key(key)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.decrypt()
    cipher.key = KEY32
    tempkey = Base64.decode64(key)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
  end

# 1. group password
# 2. key: hash(password) <-- check their password
# 3. hash(hash(password) = password_digest <-- check their password
#
# encrypt(group password(1))(my password) = sessions
# decode - hash(their password)

  def self.digest_password(password)
    OpenSSL::Digest::SHA256.new(password).digest
  end

  def self.decrypt(message, password, iv)
    cipher=OpenSSL::Cipher.new(ALGORITHM)
    cipher.decrypt()
    cipher.key = self.digest_password(password)
    cipher.iv = iv
    tempkey = Base64.decode64(message)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
  end


end

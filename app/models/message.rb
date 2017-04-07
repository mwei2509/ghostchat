class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def set_iv
    #128 bits or 16 bytes
    self.iv = SecureRandom.random_bytes(16)
  end
end

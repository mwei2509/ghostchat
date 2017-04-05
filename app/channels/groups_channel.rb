require 'encrypt_text'
class GroupsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "groups_#{params['group_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # process data sent from the page
    User.find(data['user_id']).messages.create!(body: EncryptText.encrypt(data['message']), group_id: data['group_id'])
  end
end

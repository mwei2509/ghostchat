class VideochatController < ApplicationController
  def index
    opentok = OpenTok::OpenTok.new("45815412","fd37c65fc1cc6333e6ee3e1c5828fa7422d702bb")
    session = opentok.create_session
    @session_id = session.session_id
    @token = opentok.generate_token(@session_id)
    @api_key = "45815412"
  end
end

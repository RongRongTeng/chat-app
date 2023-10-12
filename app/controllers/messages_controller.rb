# frozen_string_literal: true

class MessagesController < ApplicationController
  api :POST, '/rooms/:room_id/messages', 'Send message to a specific room'
  api :POST, '/users/:user_id/messages', 'Send message to a specific user'
  param :message, Hash, required: true do
    param :content, String, desc: 'text message content', required: true
  end
  returns code: 204
  def create
    receiveable = if (id = params[:room_id])
                    Room.find(id)
                  elsif (id = params[:user_id])
                    User.find(id)
                  end

    @message = current_user.sent_messages.create!(content: message_params[:content], receiveable:)
  end

  private

  def message_params
    params.fetch(:message, {}).permit(:content)
  end
end

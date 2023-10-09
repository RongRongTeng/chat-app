# frozen_string_literal: true

class MessagesController < ApplicationController
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

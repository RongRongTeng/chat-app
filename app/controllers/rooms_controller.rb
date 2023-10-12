# frozen_string_literal: true

class RoomsController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: %i[show]

  api :GET, '/rooms/:id', 'Get messages of a specific room'
  returns code: 200
  def show
    @current_room = Room.find(params[:id])

    @message = Message.new
    pagy_messages = @current_room.messages.includes(:user, :receiveable).order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 10)
    @messages = messages.reverse

    set_notifications_to_read

    render 'pages/home'
  end

  api :POST, '/rooms', 'Create room'
  param :room, Hash, required: true do
    param :name, String, desc: 'Name of the room', required: true
  end
  returns code: 204
  def create
    @room = Room.create!(name: room_params[:name])
  end

  private

  def room_params
    params.fetch(:room, {}).permit(:name)
  end

  def set_notifications_to_read
    notifications = @current_room.notifications_as_sender.where(recipient: current_user).unread
    # rubocop:disable Rails/SkipsModelValidations
    notifications.update_all(read_at: DateTime.current)
    # rubocop:enable Rails/SkipsModelValidations
  end
end

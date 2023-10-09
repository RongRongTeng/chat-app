# frozen_string_literal: true

class RoomsController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: %i[show]

  def show
    @current_room = Room.find(params[:id])

    @message = Message.new
    pagy_messages = @current_room.messages.includes(:user, :receiveable).order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 10)
    @messages = messages.reverse

    render 'pages/home'
  end

  def create
    @room = Room.create!(name: room_params[:name])
  end

  private

  def room_params
    params.fetch(:room, {}).permit(:name)
  end
end

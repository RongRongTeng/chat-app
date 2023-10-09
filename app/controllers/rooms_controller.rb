# frozen_string_literal: true

class RoomsController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: %i[show]

  def show
    @current_room = Room.find(params[:id])

    @message = Message.new
    @messages = @current_room.messages.includes(:user, :receiveable).order(created_at: :asc)

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

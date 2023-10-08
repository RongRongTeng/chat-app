# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms = Room.all
    @users = User.all_except(current_user)
  end

  def create
    @room = Room.create!(name: room_params[:name])
  end

  private

  def room_params
    params.fetch(:room, {}).permit(:name)
  end
end

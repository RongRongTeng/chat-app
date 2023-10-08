# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @users = User.all_except(current_user)
  end
end

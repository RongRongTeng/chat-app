# frozen_string_literal: true

class UsersController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: [:show]

  def show
    @current_room = User.find(params[:id])

    @message  = Message.new
    @messages = Message.includes(:user, :receiveable)
                       .where(users: [current_user, @current_room],
                              receiveable: [current_user, @current_room])
                       .order(created_at: :asc)

    render 'pages/home'
  end
end

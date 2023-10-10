# frozen_string_literal: true

class UsersController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: [:show]

  def show
    @current_room = User.find(params[:id])

    @message = Message.new
    pagy_messages = Message.includes(:user, :receiveable)
                           .where(users: [current_user, @current_room],
                                  receiveable: [current_user, @current_room])
                           .order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 10)
    @messages = messages.reverse

    set_notifications_to_read

    render 'pages/home'
  end

  private

  def set_notifications_to_read
    notifications = @current_room.notifications_as_sender.where(recipient: current_user).unread
    # rubocop:disable Rails/SkipsModelValidations
    notifications.update_all(read_at: DateTime.current)
    # rubocop:enable Rails/SkipsModelValidations
  end
end

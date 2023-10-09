# frozen_string_literal: true

module ActsAsReceiveableResources
  private

  def set_receiveable_resources
    @users = User.all_except(current_user)
    @rooms = Room.order(created_at: :desc)

    @room  = Room.new
  end
end

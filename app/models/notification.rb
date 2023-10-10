# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  params         :jsonb
#  read_at        :datetime
#  recipient_type :string           not null
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recipient_id   :bigint           not null
#
# Indexes
#
#  index_notifications_on_read_at    (read_at)
#  index_notifications_on_recipient  (recipient_type,recipient_id)
#
class Notification < ApplicationRecord
  include Noticed::Model

  belongs_to :recipient, polymorphic: true

  after_create_commit :broadcast_notifications_count, if: :message_notification?

  private

  def message_notification?
    type == MessageNotification.name
  end

  def broadcast_notifications_count
    receiveable = params[:sender]
    broadcast_replace_to "notifications_#{recipient.id}",
                         partial: 'shared/notifications',
                         locals: { receiveable:, current_user: recipient },
                         target: "#{receiveable.signed_id}_notifications_count"
  end
end

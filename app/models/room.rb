# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rooms_on_name  (name) UNIQUE
#
class Room < ApplicationRecord
  has_many :messages, as: :receiveable, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  after_create_commit { broadcast_prepend_to 'rooms', locals: { current_user: nil } }

  has_noticed_notifications model_name: 'Notification', param_name: :sender
end

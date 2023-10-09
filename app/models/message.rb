# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  content          :text
#  receiveable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  receiveable_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_messages_on_receiveable  (receiveable_type,receiveable_id)
#  index_messages_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receiveable, polymorphic: true

  validates :content, length: { minimum: 1, maximum: 5000 }
end
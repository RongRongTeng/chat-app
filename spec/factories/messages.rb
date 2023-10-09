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
FactoryBot.define do
  factory :room_message, class: 'Message' do
    user
    receiveable factory: :room
    sequence(:content) { |n| "room message content - #{n}" }
  end

  factory :direct_message, class: 'Message' do
    user
    receiveable factory: :user
    sequence(:content) { |n| "direct message content - #{n}" }
  end
end

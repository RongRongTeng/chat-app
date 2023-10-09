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
require 'rails_helper'

RSpec.describe Message do
  pending "add some examples to (or delete) #{__FILE__}"
end

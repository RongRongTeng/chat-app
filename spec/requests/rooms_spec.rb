# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms' do
  describe 'GET /rooms/:id' do
    subject { get "/rooms/#{room.id}" }

    let!(:user) { create(:user) }
    let!(:room) { create(:room) }

    before do
      sign_in user

      11.times do |n|
        travel_to(n.minutes.ago) do
          create(:room_message, receiveable: room, content: "message sent #{n} minutes ago in current room")
        end
      end

      create(:room_message, content: 'Lastest message sent in other room')
      create(:direct_message, receiveable: user, content: 'Lastest direct message')
    end

    it 'returns http success and render correct messages with paganation' do
      subject

      expect(response).to have_http_status(:success)

      assert_select '.message-content', text: /message sent \d{1} minutes ago in current room/
    end

    it 'marks unread messages as read' do
      expect { subject }.to change { user.notifications.unread.count }.from(13).to(2)
    end
  end
end

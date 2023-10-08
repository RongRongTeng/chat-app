# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms' do
  let!(:user)  { create(:user) }

  before { sign_in user }

  describe 'GET /rooms' do
    subject { get '/rooms' }

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end
  end
end

# frozen_string_literal: true

class PagesController < ApplicationController
  include ActsAsReceiveableResources

  before_action :set_receiveable_resources, only: %i[home]

  def home; end
end

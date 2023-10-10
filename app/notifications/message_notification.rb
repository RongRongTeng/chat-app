# frozen_string_literal: true

class MessageNotification < Noticed::Base
  deliver_by :database

  params :message
  params :sender
end

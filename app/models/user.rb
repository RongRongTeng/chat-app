# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :sent_messages, class_name: 'Message', dependent: :destroy
  has_many :received_messages, class_name: 'Message', as: :receiveable, dependent: :destroy
  has_many :notifications, dependent: :destroy, as: :recipient

  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user.id) }

  after_create_commit { broadcast_append_to 'users', locals: { current_user: nil } }

  has_noticed_notifications model_name: 'Notification', param_name: :sender

  def name
    email
  end
end

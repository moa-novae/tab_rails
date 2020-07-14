require 'twilio-ruby'
class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates_presence_of :amount, :user_id, :group_id, on: :create
  after_create do |transaction|
    send_overdraft_sms(transaction.amount, transaction.user, transaction.group)
  end

  def send_overdraft_sms (amount, user, group)
    p 'sent'
    balance = user.user_group_balance[group.id]
    if balance < -10_000
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_TOKEN']
      client = Twilio::REST::Client.new(account_sid, auth_token)
      from = ENV['TWILIO_FROM']
      to = ENV['TWILIO_TO']
      client.messages.create(
      from: from,
      to: to,
      body:  "Hey #{user.name}, your balance is #{balance} in #{group.name}"
      )
    end
  end
end

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  ALL = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    ALL << self
  end

  def self.all
    ALL
  end

  def valid?
    self.sender.valid? && self.receiver.valid? &&
    self.amount < self.sender.balance
  end

  def withdraw_and_deposit(sender, receiver)
    sender.withdraw(self.amount)
    receiver.deposit(self.amount)
  end

  def execute_transaction
    if self.valid? && self.status == "pending"
      withdraw_and_deposit(self.sender, self.receiver)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      withdraw_and_deposit(self.receiver, self.sender)
      self.status = "reversed"
    end
  end

end

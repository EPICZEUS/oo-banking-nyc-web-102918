class Transfer
	attr_reader :sender, :receiver, :amount, :status

	def initialize(sender, receiver, amount)
		@sender = sender
		@receiver = receiver
		@amount = amount
		@status = "pending"
	end

	def valid?
		@sender.valid? && @receiver.valid?
	end

	def execute_transaction
		return if @status == "complete"

		if self.valid? && @sender.balance >= @amount
			@sender.balance -= @amount
			@receiver.balance += @amount
			@status = "complete"
		else
			@status = "rejected"
			"Transaction rejected. Please check your account balance."
		end
	end

	def reverse_transfer
		return unless @status == "complete"

		@sender.balance += @amount
		@receiver.balance -= @amount
		@status = "reversed"
	end
end

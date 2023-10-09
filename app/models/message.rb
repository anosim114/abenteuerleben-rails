class Message < ApplicationRecord
  def desc_short
    if self.message.length > 70
      return "#{self.message[0..50]}..."
    end

    self.message
  end
end

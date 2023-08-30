class User < ApplicationRecord
  def is_admin
    return self.level == 0x111
  end
end

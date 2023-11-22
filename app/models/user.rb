class User < ApplicationRecord
  # 0b000

  # 0b001 => read
  # 0b010 => change
  # 0b100 => delete

  def is_admin
    return self.level > 0
  end

  def has_read_rights
    return self.level >= 0b001
  end

  def has_change_rights
    return self.level >= 0b010
  end

  def has_delete_rights
    return self.level >= 0b100
  end

  def is_moderator
    return self.level == 0b001
  end
end

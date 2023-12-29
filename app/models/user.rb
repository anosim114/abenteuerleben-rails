class User < ApplicationRecord
  # 0b000

  # 0b001 => read
  # 0b010 => change
  # 0b100 => delete

  def is_admin
    level > 0
  end

  def has_read_rights
    level >= 0b001
  end

  def has_change_rights
    level >= 0b010
  end

  def has_delete_rights
    delete_rights?
  end

  def delete_rights?
    level >= 0b100
  end

  def is_moderator
    level == 0b001
  end
end

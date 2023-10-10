class Helper < ApplicationRecord
  has_many :registrations, dependent: :destroy
  accepts_nested_attributes_for :registrations, allow_destroy: true, reject_if: :all_blank

  validates :surname, presence: true
  validates :forename, presence: true
  validates :birthday, presence: true
  validates :telephone, presence: true
  validates :email, presence: true
  validates :streethouse, presence: true
  validates :postcity, presence: true
  validates :story, presence: true

  validate :has_at_least_one_participate
  validate :camps_are_not_the_same

  def camps_are_not_the_same
    self.registrations.each do |r|
      if r.wish_first == Registration::team_free_value or r.wish_second == Registration::team_free_value
        next
      elsif r.wish_first != r.wish_second
        next
      end

      self.errors.add :duplicate_team, "Camp #{r.camp.participants_year_start}-#{r.camp.participants_year_end}: Teams dürfen nicht doppelt angegeben werden"
    end
  end

  def has_at_least_one_participate
    has_participations = self.registrations.any? { |reg| reg.participate }

    self.errors.add :participation, 'Mindestend ein Camp muss ausgewählt werden' unless has_participations
  end
end

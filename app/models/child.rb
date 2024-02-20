class Child < ApplicationRecord
  belongs_to :parent, class_name: 'Parent::Parent', optional: true
  belongs_to :camp

  validates :surname, presence: true, on: %i[form create update]
  validates :forename, presence: true, on: %i[form create update]
  validates :birthday, presence: true, on: %i[form create update]
  validates :sex, presence: true, on: %i[form create update]
  validates :camp_id, presence: true, on: %i[form create update]

  # validates :parent_id, presence: true, on: %i[create]

  def self.from_year year
    Child.joins(camp: :campyear)
       .where('campyears.year': year)
       .order(:surname)
       .distinct
  end

  def actions
    [
      {text: 'Kinddaten ändern', href: Rails.application.routes.url_helpers.edit_child_path(id)},
      {text: 'Elterndaten ändern', href: Rails.application.routes.url_helpers.edit_parent_parent_path(parent.id)},
      {text: '#'},
      {text: 'Neue Bestätigungsmail versenden', js_function: "resendParentVerificationEMail(#{parent.id})"},
    # {text: 'Löschen (bald)', method: 'DELETE', href: child_url(@child)},
    ]
  end

  def invalid?
    !valid?
  end
end

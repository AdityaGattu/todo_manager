class Todo < ActiveRecord::Base
  belongs_to :user
  #has table user
  #todo table will contain user id.
  validates :todo_text, presence: true
  validates :due_date, presence: true

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}.  #{display_status} #{todo_text} #{display_date}"
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.over_due
    where("due_date < ? and (not completed)", Date.today)
  end

  def due_today?
    due_date == Date.today
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

  def self.not_completed
    all.where(completed: false)
  end
end

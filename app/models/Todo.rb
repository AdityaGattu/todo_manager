class Todo < ActiveRecord::Base
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}.  #{display_status} #{todo_text} #{display_date}"
  end

  def self.add_task(todo)
    create!(todo_text: todo[:todo_text], due_date: Date.today + todo[:due_in_days])
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

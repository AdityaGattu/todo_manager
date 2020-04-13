class Todo < ActiveRecord::Base
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}.  #{display_status} #{todo_text} #{display_date}"
  end

  def self.add_task(new_task)
    todo_text = new_task[:todo_text]
    due_date = DateTime.parse(new_task[:due_date])
    completed = false
    create!(todo_text: todo_text, due_date: due_date, completed: completed)
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

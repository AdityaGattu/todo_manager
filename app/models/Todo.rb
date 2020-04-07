class Todo < ActiveRecord::Base
  def to_pleasant_string
    is_completed = completed ? "[X]" : "[]"
    "#{id}.#{due_date.to_s(:long)} #{todo_text} #{is_completed}"
  end
  def self.over_due
    all.where("due_date < ?", Date.today)
  end
  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def due_today?
    due_date == Date.today
  end

  def self.completed
    all.where(completed: true)
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}.  #{display_status} #{todo_text} #{display_date}"
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts over_due.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_displayable_string }
    puts "\n\n"
  end

  def self.add_task(todo)
    create!(todo_text: todo[:todo_text], due_date: Date.today + todo[:due_in_days])
  end

  def self.mark_as_complete!(todo_id)
    update(todo_id, completed: true)
  end
end

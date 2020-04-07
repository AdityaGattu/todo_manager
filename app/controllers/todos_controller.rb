# todos_controller.rb
class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    #render plain: Todo.all.order(:due_date).map { |todo| todo.to_pleasant_string }.join("\n")
    render "index"
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_pleasant_string
  end

  def create
    todo_text = params[:todo_text]
    due_date = DateTime.parse(params[:due_date])
    new_todo = Todo.create!(
      todo_text: todo_text,
      due_date: due_date,
      completed: false,
    )
    response_text = " hey, new todo created with id #{new_todo.id}"
    render plain: response_text
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.update(id, completed: completed)
    render plain: "Updated todo completed status to #{completed}"
  end
end

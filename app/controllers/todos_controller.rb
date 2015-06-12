class TodosController < ApplicationController

  before_action :authenticate_user! # all actions

  def index
    @todos = current_user.todos.select("id, content, completed").to_json
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    render nothing: true, status:  200
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params)
    render nothing: true, status:  200
  end

  def destroy
    Todo.find(params[:id]).destroy
    render nothing: true, status:  200
  end

  private

    def todo_params
      params.require(:todo).permit(:content, :completed)
    end
end

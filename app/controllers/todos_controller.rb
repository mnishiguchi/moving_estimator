class TodosController < ApplicationController

  before_action :authenticate_user! # all actions

  def index
    @todos = Todo.select("id, content").where(user: current_user).to_json
  end

  def create
    @todo = current_user.todos.build(todo_params)
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params)
  end

  def destroy
    Todo.find(params[:id]).destroy
  end

  private

    def todo_params
      params.require(:todo).permit(:content)
    end
end

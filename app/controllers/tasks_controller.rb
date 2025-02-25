class TasksController < ApplicationController
    protect_from_forgery with: :null_session

    def new
        @task = Task.new
    end

    def create
        task = Task.new(create_params)

        if task.save
            redirect_to root_path
        else
            error_message(task)

        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        task = Task.find(params[:id])

        if task.present? and task.update(update_params)
            redirect_to tasks_path
        else
            error_message(task)
        end
    end

    def destroy
        task = Task.where(id: params[:id])

        if task.present? and task.first.destroy
            respond_to do |format|
                format.js
            end
        else
            render json: { errors: "Task not found" }, status: 422
        end
    end

    def index
        @q = Task.ransack(params[:q])
        @tasks = @q.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
    
    def search 
        Task.where("title ilike ?", params[:title])
    end

    private

    def create_params
        params.require(:task).permit(:title, :deadline, :priority)
    end

    def update_params
        params.require(:task).permit(:title, :deadline, :priority) 
    end

    def destroy_task
        params.require(:task).permit(:title, :deadline, :priority)
    end

    def error_message(task)
        render json: { errors: task.errors.full_messages}, status: 422
    end
end

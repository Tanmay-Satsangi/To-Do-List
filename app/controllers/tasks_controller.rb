class TasksController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        task = Task.new(create_params)

        if task.save
            respond_to do |format|
                # If the request is AJAX
                format.js   # This will call `create.js.erb`
            end
        else
            error_message(task)
        end
    end

    def edit

    end

    def update
        task = Task.find(params[:id])

        if task.present? and task.update(task: update_params[:task])
            render json: { message: "Task Updated Successfully !!!"}, status: 200
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
        @tasks = @q.result.paginate(page: params[:page], per_page: 10)
    end
    
    def search 
        Task.where("title ilike ?", params[:title])
    end

    private

    def create_params
        params.require(:task).permit(:title)
    end

    def update_params
        params.permit(:title)
    end

    def destroy_task
        params.permit(:title)
    end

    def error_message(task)
        render json: { errors: task.errors.full_messages}, status: 422
    end
end

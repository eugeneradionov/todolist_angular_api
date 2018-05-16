class Api::V1::UpdateTaskService
  def initialize(task, task_params)
    @task = task
    @task_params = task_params
  end

  def update
    return change_position if @task_params[:move]
    @task.update(@task_params)
  end

  private

  def change_position
    case @task_params[:move]
      when '1'
        @task.move_higher
      when '-1'
        @task.move_lower
      else
        false
    end
  end
end

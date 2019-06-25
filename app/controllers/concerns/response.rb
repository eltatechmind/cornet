module Response
  def json_response(object, status = :ok)
    if (object.class.to_s == "Project::ActiveRecord_Relation" || object.class.to_s == "Project" || object.class.to_s == "Project::ActiveRecord_Associations_CollectionProxy")
      render json: ProjectSerializer.new(object).serialized_json, status: status
    elsif (object.class.to_s == "Task::ActiveRecord_Relation" || object.class.to_s == "Task" || object.class.to_s == "Task::ActiveRecord_Associations_CollectionProxy")
      render json: TaskSerializer.new(object).serialized_json, status: status
    else
    render json: object, status: status
    end
  end
end

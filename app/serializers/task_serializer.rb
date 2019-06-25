class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :plevel, :deadline, :done
  belongs_to :project
end

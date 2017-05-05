class Project
  attr_reader(:name,:id)
def initialize (attributes)
  @name = attributes[:name]
  @id = attributes[:id]
end

def == (another_project)
  self.name().==(project.name()).&(self.id().==(another_project.id()))
end

def save
  result= DB.exec("INSERT INTO projects(name)VALUES('#{@name}')RETURNING id;")
  @id = result.first().fetch("id").to_i()
end

def self.all
  returned_projects = DB.exec("SELECT * FROM projects")
  projects = []
  returned_projects.each() do |proj|
    name = proj.fetch("name")
    id = proj.fetch("id").to_id()
    projects.push(Project.new({:name => name, :id => id}))
  end
  projects
end


end

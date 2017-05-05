class Project
  attr_reader(:name,:id)

def initialize (attributes)
  @name = attributes[:name]
  @id = attributes[:id]
end

def self.all
  returned_projects = DB.exec("SELECT * FROM projects;")
  projects = []
  returned_projects.each() do |proj|
    name = proj.fetch("name")
    id = proj.fetch("id").to_i()
    projects.push(Project.new({:name => name, :id => id}))
  end
  projects
end

def save
  result= DB.exec("INSERT INTO projects(name)VALUES ('#{@name}') RETURNING id;")
  @id = result.first().fetch("id").to_i()
end

def == (another_project)
  self.name().==(project.name()).&(self.id().==(another_project.id()))
end

def find (test)
  found_project = nil
  Project.all().each() do |projects|
    if projects.id().==(test)
      found_project == projects
    end
  end
  found_project
end

def update (attributes)
  @name = attributes.fetch(:name)
  @id = self.id()
  DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
end

def volunteer
  project_volunteer = []
  volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
  volunteers.each() do |volunteer|
    name = volunteer.fetch("name")
    project_id = volunteer.fetch("project_id").to_i()
    id = volunteer.fetch("id").to_i()
    project_volunteer.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
  end
  project_volunteer
end

def delete
  DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
end
end

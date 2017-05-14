require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get("/projects/new") do
  @projects = Project.all()
  erb(:projects)
end

post("/projects") do
  name = params.fetch("name")
  project = Project.new({:name => name, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:projects)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_result)
end

get('/volunteers')do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  @volunteer.save()
  erb(:project_result)
end

get("/projects/:id/edit") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/projects/:id") do
  name = params.fetch("name")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:name => name})
  erb(:project_result)
end

delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:projects)
end



get("/volunteers/:id/edit") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteers = Volunteer.all()
  erb(:volunteer_edit)
end

patch("/volunteers/:id") do
  name = params.fetch("name")
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.update({:name => name})
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

delete("/volunteers/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.delete()
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

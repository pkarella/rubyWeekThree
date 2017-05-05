require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  @projects= Project.all()
  erb(:index)
end

post("/projects") do
  name = params.fetch("name")
  projects = Project.new({:name => name,:id => nil})
  projects.save()
  @projects = Project.all()
  erb(:index)
end

get("/projects/:id") do
 @projects = Project.find(params.fetch("id").to_i())
 @volunteers = Volunteer.all()
 erb(:program_result)
end

post("/projects/new") do
  description = params.fetch("name")
  list_id = params.fetch("project_id").to_i()
  volunteer = Volunteer.new({:name => description, :project_id => project_id})
  volunteer.save()
  @voluteers = Volunteer.all()
  @projects = Project.find(project_id)
  erb(:program_result)
end


get("/projects/:id/edit") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/projects/:id") do
  name = params.fetch("name")
  @projects = Project.find(params.fetch("id").to_i())
  @projects.update({:name => name})
  @volunteers = Volunteer.all()
  erb(:program_result)
end

delete("/projects/:id") do
  @projects = Project.find(params.fetch("id").to_i())
  @projects.delete()
  @projects = List.all()
  erb(:index)
end

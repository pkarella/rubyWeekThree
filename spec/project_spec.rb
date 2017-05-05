require('spec_helper')

describe(Project) do
  describe("#==") do
    it("is the same project if it is the same description")do
    projectone = Project.new({:name => "peter"})
    projecttwo = Project.new({:name => "peter"})
    expect(projectone).to(eq(projecttwo))
  end
end
describe("#name") do
    it("tells you its name") do
      project = Project.new({:name => "cool", :id => nil})
      expect(project.name()).to(eq("cool"))
    end
  end
describe("#id")do
  it("sets an id fixnum")do
    project = Project.new({:name=>"cool", :id=>nil})
    project.save()
    expect(project.id()).to(be_an_instance_of(Fixnum))
  end
end
describe(".all") do
   it("is empty at first") do
     expect(Project.all()).to(eq([]))
   end
 end

 describe ("#save") do
   it("adds a project to the array of saved projects")do
     test_project = Project.new({:name => "peter is cool",:id =>nil})
     test_project.save()
     expect(Project.all()).to(eq([test_project]))
   end
 end
end

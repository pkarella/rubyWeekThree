require('spec_helper')


describe(Volunteer) do
  describe(".all") do
  it("is empty") do
    expect(Volunteer.all()).to(eq([]))
  end
end

describe("#save") do
  it("adds a task to the array of saved tasks") do
    test_volunteer = Volunteer.new({:id => nil, :name => "Peter", :project_id => 1})
    test_volunteer.save()
    expect(Volunteer.all()).to(eq([test_volunteer]))
  end
end

describe("#name") do
  it("lets you read the name of a volunteer") do
    test_volunteer = Volunteer.new({:id => nil, :name => "wolfman", :project_id => 1})
    expect(test_volunteer.name()).to(eq("wolfman"))
  end
end

  describe("#==") do
   it("is the same volunteer if it has the same name") do
     volunteer1 = Volunteer.new({:id => nil, :name => "happy", :project_id => 1})
     volunteer2 = Volunteer.new({:id => nil, :name => "happy", :project_id => 1})
     expect(volunteer1).to(eq(volunteer2))
   end
 end

 describe("#update") do
   it("lets you update volunteers in the database") do
     volunteer = Volunteer.new({:id => nil, :name => "John", :project_id => 1})
     volunteer.save()
     volunteer.update({:name => "Dan"})
     expect(volunteer.name()).to(eq("Dan"))
   end
 end
 end

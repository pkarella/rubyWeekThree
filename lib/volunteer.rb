class Volunteer
  attr_reader(:name,:project_id,:id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id).to_i()
    @id = attributes.fetch(:id).to_i()
  end

  define_singleton_method(:all) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id,:id => id}))
    end
    volunteers
  end

  define_singleton_method(:find) do |id|
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id().==(id)
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  define_method(:save) do
    result= DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_volunteer|
    self.name().==(another_volunteer.name()).&(self.project_id().==(another_volunteer.project_id()))
  end


define_method(:update) do |attributes|
  @name = attributes.fetch(:name)
  @id = self.id().to_i()
  DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
end

define_method(:delete) do
  DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  DB.exec("DELETE FROM volunteers WHERE id = #{self.id()}")
end
end

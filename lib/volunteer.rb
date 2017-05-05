class volunteer
    attr_reader(:name,:id)
  def initialize (attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def == (another_volunteer)
    self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id()))
  end

  def save
    result= DB.exec("INSERT INTO volunteers (name)VALUES('#{@name}')RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each() do |vol|
      name = vol.fetch("name")
      id = vol.fetch("id").to_id()
      volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    volunteers
  end


  end
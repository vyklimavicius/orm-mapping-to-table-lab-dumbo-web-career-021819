# require_relative '../config/environment.rb'

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql =<<-SQL
    CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =<<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql =<<-SQL
    INSERT INTO students(name,grade) VALUES(?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name: , grade:)
    new_student = Student.new(name,grade)
    new_student.save
    new_student
  end

end

# josh = Student.new("Josh", "11th")
# p Student.create(name: "Clark", grade: "9th")
# (name:"Clark", grade:"9th")

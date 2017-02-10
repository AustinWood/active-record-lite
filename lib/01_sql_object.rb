require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    result = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = result.first.map { |el| el.to_sym }
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) do
        attributes[col]
      end

      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    if @table_name.nil?
      @table_name = "#{self}s".downcase
    end
    @table_name
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    objs = []
    results.each do |params|
      objs << self.new(params)
    end
    objs
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |k, v|
      sym = k.to_sym
      unless self.class.columns.include?(sym)
        raise "unknown attribute '#{k}'"
      end
      self.send("#{k}=", v)
    end
  end

  def attributes
    @attributes ||= {}
    @attributes
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

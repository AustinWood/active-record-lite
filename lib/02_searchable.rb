require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    key_str = []
    vals = []
    params.each do |k, v|
      key_str << k.to_s
      vals << v
    end
    where_str = key_str.map{ |e| "#{e} = ?" }.join(" AND ")
    results = DBConnection.execute(<<-SQL, *vals)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_str}
    SQL
    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end

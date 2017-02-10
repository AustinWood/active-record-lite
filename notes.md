To aid in debugging, we've also coded an option into the skeleton so you can print all the queries and interpolation arguments that get sent to the SQL engine. To enable this, pass PRINT_QUERIES=true as an ENV variable when you run the rspec command.

$ PRINT_QUERIES=true rspec spec/01_sql_object_spec.rb

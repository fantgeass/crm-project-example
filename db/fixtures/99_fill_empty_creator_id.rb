c = ActiveRecord::Base.connection
tables = c.tables

for table in tables
  result = c.execute("SHOW columns from `#{table}` where field='creator_id'")

  if result.count > 0 # if creator_id column exist
    query = "UPDATE `#{table}` SET creator_id=1 WHERE creator_id IS NULL"
    c.execute(query)
  end
end
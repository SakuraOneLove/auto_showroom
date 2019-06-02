require 'test_helper'

class CourseWorkControllerTest < ActionDispatch::IntegrationTest
  test "data base muste be exist" do
    assert File.exist?('db/development.sqlite3')
  end

  test "should 12 or more tables" do
    sql = "SELECT COUNT(*) FROM sqlite_master WHERE type = 'table' AND name != 'sqlite_sequence' AND name != 'schema_migrations'
      AND name != 'ar_internal_metadata'"
    assert_equal 12, ActiveRecord::Base.connection.execute(sql)[0][0]
  end

  test "row should be added" do
    assert_equal 2, User.count
    assert_equal 2, Order.count
    assert_equal 2, Customer.count
  end

  test "request should be execute" do # com_query
    assert_equal 2, ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM users WHERE id IN (SELECT id FROM users WHERE email='MyString')")[0][0]
  end
end

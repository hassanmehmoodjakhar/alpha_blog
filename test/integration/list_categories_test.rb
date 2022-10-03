require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.new(name: "Sports")
    @category2 = Category.new(name: "Travel")
  end

  test "should show categories listing" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end

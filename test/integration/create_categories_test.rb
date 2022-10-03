require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success

    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Sports" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body

  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success

    assert_no_difference("Category.count", 1) do
      post categories_url, params: { category: { name: " " } }
      
    end

    assert_match "errors", response.body

  end
end

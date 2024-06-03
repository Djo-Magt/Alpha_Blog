require "test_helper"

# rails generate integration_test create_category

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new cat form and create cat" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end


  test "get new cat form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    assert_select 'div.invalid-feedback'
  end
end

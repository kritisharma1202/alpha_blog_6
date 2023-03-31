require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new" #this will get the new category form page
    assert_response :success  #it will give the success response if get the form for new category
    assert_difference 'Category.count', 1 do  #it will check if category count is increemented by one to check creating new category
      post categories_path, params: { category: { name: "Health" }} #post to create action for submitting data with parameters
      assert_response :redirect #after creating new category redirect to its show page
    end
    follow_redirect!  #this will follow the redirection, it is helper method
    assert_response :success  #give success response if successfully redirected
    assert_match "Health", response.body #find and match the category in the body of show page
  end
end

require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignments)
  end

  test "should get an assignment" do
    assignment = create :assignment
    get :show, {'id' => assignment.id}
    assert_response :success
    assert_not_nil assigns(:assignment)
  end

  test "should provide an empty form for creating a new assignment" do
    get :new
    assert_response :success
    assert_select 'input[type=text]', true
    assert_select 'input[type=text][value]', false
  end

  test "should provide a filled-in form for creating a new assignment" do
    assignment = create :assignment
    get :edit, {'id' => assignment.id}
    assert_response :success
    assert_select 'input[type=text][value]', true
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post :create, assignment: {title: 'Test',
                                 description: 'A test assignment',
                                 run_script: 'nothing'}
    end

    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "should fail to create bad assignment" do
    assert_no_difference('Assignment.count') do
      post :create, assignment: {title: 'Missing Data'}
    end
    assert_response :success
    assert assigns(:assignment).errors.added? :description, :blank
    assert assigns(:assignment).errors.added? :run_script, :blank
  end

  test "should update assignment" do
    assignment = create :assignment
    patch :update, id: assignment.id, assignment: {title: "Some New Thing"}
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "should fail to update bad assignment" do
    assignment = create :assignment
    patch :update, id: assignment.id, assignment: {title: "I"}
    assert_response :success
    assert assigns(:assignment).errors.include? :title
  end

  test "should destroy assignment" do
    assignment = create :assignment
    assert assignment.persisted?
    assert_difference('Assignment.count', -1) do
      delete :destroy, id: assignment.id
    end
    assert_redirected_to assignments_path
  end
end

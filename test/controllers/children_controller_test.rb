require 'test_helper'

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get children_url
    assert_response :success
  end

  test 'should get show' do
    get child_url(children(:one))
    assert_response :success
  end

  test 'should get new' do
    get new_child_url
    assert_response :success
  end

  test 'missing surname should not create child' do
    post children_url, params: { child: {
      surname: 'this',
      forename: 'that',
      'birthday(3i)': '21',
      'birthday(2i)': '12',
      'birthday(1i)': '2012',
      sex: 'Junge',
      camp_id: camps(:one).id
    } }

    assert :unprocessable_entity
  end

  test 'missing forename should not create child' do
    post children_url, params: { child: {
      surname: 'this',
      'birthday(3i)': '21',
      'birthday(2i)': '12',
      'birthday(1i)': '2012',
      sex: 'Junge',
      camp_id: camps(:one).id
    } }

    assert :unprocessable_entity
  end

  test 'missing camp should not create child' do
    post children_url, params: { child: {
      surname: 'this',
      forename: 'that',
      'birthday(3i)': '21',
      'birthday(2i)': '12',
      'birthday(1i)': '2012',
      sex: 'Junge'
    } }

    assert :unprocessable_entity
  end

  test 'should create child' do
    post children_url, params: { child: {
      surname: 'this',
      forename: 'that',
      'birthday(3i)': '21',
      'birthday(2i)': '12',
      'birthday(1i)': '2012',
      sex: 'Junge',
      camp_id: camps(:one).id
    } }

    assert :redirect
  end

  # test 'should get edit' do
  #   get children_edit_url(children[:one])
  #   assert_response :success
  # end

  # test 'should get update' do
  #   post children_update_url(children[:one])
  #   assert_response :success
  # end

  test 'should destroy child' do
    assert_difference('Child.count', -1) do
      delete child_url(children(:one))
    end

    assert_redirected_to children_path
  end

  # TODO
  # test 'destroying last child also destroys parent' do
  #   assert_difference('Child.count', -1) do
  #     delete child_url(children(:one))
  #   end

  #   assert_redirected_to children_path
  # end
end

require 'test_helper'

class CampTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'that camp is full' do
    # prepare
    camp = Camp.new({ max_participant_count: 2, children: [Child.new, Child.new, Child.new] })

    # execute && check
    assert camp.full?
  end

  test 'that camp is not full' do
    # prepare
    camp = Camp.new({ max_participant_count: 2, children: [Child.new] })

    # execute && check
    assert_not camp.full?
  end
end

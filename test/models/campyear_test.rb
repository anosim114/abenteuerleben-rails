require 'test_helper'

class CampyearTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'that campyear is full' do
    # prepare
    camp1 = Camp.new({ max_participant_count: 2, children: [Child.new, Child.new] })
    camp2 = Camp.new({ max_participant_count: 2, children: [Child.new, Child.new, Child.new] })
    campyear = Campyear.new({ camps: [camp1, camp2] })

    # execute & check
    assert campyear.full?
  end

  test 'that campyear has some space' do
    # prepare
    camp1 = Camp.new({ max_participant_count: 17, children: [Child.new, Child.new] })
    camp2 = Camp.new({ max_participant_count: 2, children: [Child.new, Child.new, Child.new] })
    campyear = Campyear.new({ camps: [camp1, camp2] })

    # execute & check
    assert_not campyear.full?
  end
end

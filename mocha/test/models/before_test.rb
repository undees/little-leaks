require 'test_helper'

class FootTest < ActiveSupport::TestCase
  test 'quadruped detection' do
    Foot.expects(:count).returns(4)
    assert Foot.belongs_to_quadruped?
  end

  test 'biped default' do
    assert_equal 2, Foot.count
  end
end

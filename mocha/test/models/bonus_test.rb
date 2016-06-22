require 'test_helper'

class FootTest < ActiveSupport::TestCase
  include Mocha::Hooks

  teardown do
    mocha_teardown
  end

  test 'quadriped detection' do
    Foot.expects(:count).returns(4)
    assert Foot.belongs_to_quadriped?
  end

  test 'biped default' do
    assert_equal 2, Foot.count
  end
end

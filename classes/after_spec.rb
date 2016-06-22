class FavoriteThing
  class Raindrops < FavoriteThing; end
  class Whiskers  < FavoriteThing; end

  ALL = [
    Raindrops.new,
    Whiskers.new
  ]

  def better_than_a_bee_sting?
    true
  end
end

RSpec.describe FavoriteThing do
  it 'always ends in S for some reason' do
    ObjectSpace.each_object(FavoriteThing) do |thing|
      last_letter = thing.class.to_s[-1]
      expect(last_letter).to eq('s')
    end
  end

  context 'a new kind' do
    after do
      # HAHA srsly no, just delete the test
      GC.start
    end

    it 'helps me get over bee stings' do
      Wine = Class.new(FavoriteThing)
      expect(Wine.new).to be_better_than_a_bee_sting
    end
  end
end

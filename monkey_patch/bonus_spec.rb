module DoItLive
  class << self
    def after_delay(delay, &block)
      sleep delay
      block.call
    end
  end
end

module MonkeyPatches
  def self.become_impatient!
    DoItLive.module_eval do
      class << self
        raise('DOUBLE MONKEY') if method_defined?(:old_after_delay)
        alias_method :old_after_delay, :after_delay

        def after_delay(delay, &block)
          block.call
        end
      end
    end
  end

  def self.chillax!
    DoItLive.module_eval do
      class << self
        raise('DOUBLE UNPATCH') unless method_defined?(:old_after_delay)
        alias_method :after_delay, :old_after_delay
        undef :old_after_delay
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:example, :monkey_patches) do
    MonkeyPatches.become_impatient!
  end

  config.after(:example, :monkey_patches) do
    MonkeyPatches.chillax!
  end
end

RSpec.describe DoItLive do
  context 'integration spec' do
    it 'waits before acting' do
      expect(DoItLive).to receive(:sleep).with(5)
      DoItLive.after_delay(5) { 'WHOA' }
    end
  end

  context 'unit spec', :monkey_patches do
    it 'preserves the return value' do
      result = DoItLive.after_delay(1) { 'ALL DONE' }
      expect(result).to eq('ALL DONE')
    end
  end
end

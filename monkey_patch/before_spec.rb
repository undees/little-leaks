module DoItLive
  class << self
    def after_delay(delay, &block)
      sleep delay
      block.call
    end
  end
end

def become_impatient!
  DoItLive.module_eval do
    class << self
      alias_method :old_after_delay, :after_delay

      def after_delay(delay, &block)
        block.call
      end
    end
  end
end

def chillax!
  DoItLive.module_eval do
    class << self
      alias_method :after_delay, :old_after_delay
      undef :old_after_delay
    end
  end
end

RSpec.describe DoItLive do
  it 'waits before acting' do
    expect(DoItLive).to receive(:sleep).with(5)
    DoItLive.after_delay(5) { 'WHOA' }
  end

  it 'preserves the return value' do
    become_impatient!
    result = DoItLive.after_delay(5) { 'ALL DONE' }
    expect(result).to eq('ALL DONE')
    # Whoops! We forgot to put a call to chillax! here
  end
end

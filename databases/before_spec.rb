require 'sequel'

DB = Sequel.sqlite('clouds.db')

RSpec.configure do |config|
  config.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'migrations')
    DB[:clouds].truncate
  end
end

RSpec.describe 'Cloud tracker' do
  context 'on a clear day' do
    it 'reports that there are no clouds' do
      expect(DB[:clouds].count).to eq(0)
    end
  end

  context 'with a cirrus cloud' do
    before do
      DB[:clouds].insert(type: 'cirrus', spotted_at: Time.now)
    end

    it 'reports the cloud' do
      expect(DB[:clouds].map(:type)).to eq(['cirrus'])
    end
  end
end

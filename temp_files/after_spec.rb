require 'fileutils'

RSpec.describe 'Dear Diary' do
  before do
    FileUtils.rm Dir['diary/*.txt']
  end

  it 'starts empty' do
    expect(Dir['diary/*.txt']).to be_empty
  end

  it 'lets me add deep thoughts' do
    FileUtils.touch('diary/deep_thoughts.txt')
    expect(Dir['diary/*.txt']).not_to be_empty
  end
end

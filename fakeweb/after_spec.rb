require 'fakeweb'

RSpec.describe 'The information superhighway' do
  before do
    FakeWeb.register_uri(
      :get, 'http://google.com',
      body: 'Welcome online!')
  end

  after do
    FakeWeb.clean_registry
  end

  it 'gets me online' do
    response = Net::HTTP.get('google.com', '/')
    expect(response).to eq('Welcome online!')
  end
end

RSpec.describe 'My new browser, AdjectiveAnimal' do
  it 'handles redirects' do
    response = Net::HTTP.get('google.com', '/')
    expect(response).to include('Moved')
  end
end

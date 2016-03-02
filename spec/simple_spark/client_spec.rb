require 'spec_helper'

describe SimpleSpark::Client do
  describe :initialize do
    it 'will raise when no API key provided' do
      expect { SimpleSpark::Client.new }.to raise_error(SimpleSpark::Exceptions::InvalidConfiguration, 'You must provide a SparkPost API key')
    end

    context 'defaults' do
      let(:client) { SimpleSpark::Client.new('mykey') }
      specify { expect(client.instance_variable_get(:@api_key)).to eq('mykey') }
      specify { expect(client.instance_variable_get(:@api_host)).to eq('https://api.sparkpost.com') }
      specify { expect(client.instance_variable_get(:@base_path)).to eq('/api/v1/') }
      specify { expect(client.instance_variable_get(:@session).class).to eq(Excon::Connection) }
      specify { expect(client.instance_variable_get(:@debug)).to eq(false) }
    end

    it 'will use the API key from the ENV var' do
      with_modified_env SPARKPOST_API_KEY: 'mykey' do
        expect(SimpleSpark::Client.new.instance_variable_get(:@api_key)).to eq('mykey')
      end
    end

    it 'will use the API host from the ENV var' do
      with_modified_env SPARKPOST_API_HOST: 'http://www.myhost.com' do
        expect(SimpleSpark::Client.new('mykey').instance_variable_get(:@api_host)).to eq('http://www.myhost.com')
      end
    end

    it 'will use the base_path provided' do
      expect(SimpleSpark::Client.new('mykey', nil, 'base').instance_variable_get(:@base_path)).to eq('base')
    end

    it 'will use the debug option provided' do
      expect(SimpleSpark::Client.new('mykey', nil, nil, true).instance_variable_get(:@debug)).to eq(true)
    end
  end
end

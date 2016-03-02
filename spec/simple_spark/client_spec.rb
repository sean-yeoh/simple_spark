require 'spec_helper'

describe SimpleSpark::Client do
  describe :initialize do
    it 'will raise when no API key provided' do
      expect { SimpleSpark::Client.new }.to raise_error(SimpleSpark::Exceptions::InvalidConfiguration, 'You must provide a SparkPost API key')
    end
  end
end

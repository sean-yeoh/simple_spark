require 'spec_helper'

describe SimpleSpark::Exceptions::Error do
  describe :fail_with_exception_for_status do
    it 'will respond with the SparkPost error code' do
      errors = [{'message' => "Test Error Message", 'code' => 3005}]
      expect{SimpleSpark::Exceptions::Error.fail_with_exception_for_status(400, errors)}.to raise_error(SimpleSpark::Exceptions::BadRequest, "Test Error Message 400 (Error Code: 3005)")
    end
  end
end
require 'spec_helper'

describe SimpleSpark::Exceptions::Error do
  describe :fail_with_exception_for_status do
    it 'will respond with the SparkPost error code' do
      errors = [{'message' => "Test Error Message", 'code' => 3005}]
      results = [{"total_rejected_recipients": 1, "total_accepted_recipients": 0, "id": "123" } }}]
      expect{SimpleSpark::Exceptions::Error.fail_with_exception_for_status(400, errors, results)}.to raise_error(SimpleSpark::Exceptions::BadRequest, "Test Error Message 400 (Error Code: 3005)")
    end
  end
end
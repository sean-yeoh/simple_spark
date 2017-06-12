module SimpleSpark
  module Exceptions
    # Adding an object to the exception to pass errors back
    # begin
    #   raise Error.new({ id: '1' }), "a message"
    # rescue Error => e
    #   puts e.message # => "a message"
    #   puts e.object # => { id: '1' }
    # end
    class Error < StandardError
      attr_reader :object, :results

      def initialize(object = nil, results = {})
        @object = object
        @results = results
      end
      
      def transmission_id
        results['id']
      end

      def self.fail_with_exception_for_status(status, errors, results)
        exception = status_codes[status.to_s] || status_codes['default']
        fail exception.new(errors, results), errors.map { |e| "#{e['message']} #{status} (Error Code: #{e['code']})" + (e['description'] ? ": #{e['description']}" : '') }.join(', ')
      end

      def self.status_codes
        {
          'default' => Exceptions::UnprocessableEntity,
          '400' => Exceptions::BadRequest,
          '404' => Exceptions::NotFound,
          '422' => Exceptions::UnprocessableEntity,
          '420' => Exceptions::ThrottleLimitExceeded,
          '429' => Exceptions::ThrottleLimitExceeded
        }
      end
    end

    class InvalidConfiguration < Error; end
    class BadRequest < Error; end
    class NotFound < Error; end
    class UnprocessableEntity < Error; end
    class ThrottleLimitExceeded < Error; end
    class GatewayTimeoutExceeded < Error; end
  end
end

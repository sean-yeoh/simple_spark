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
      attr_reader :object

      def initialize(object)
        @object = object
      end
    end

    class InvalidConfiguration < Error; end
    class DeliveryException < Error; end
  end
end

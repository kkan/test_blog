module Creators
  class BaseCreator
    attr_reader :result

    def initialize(form_object)
      @form_object = form_object
    end

    def process
      @result = Result.new
    end

    private

    def write_form_errors
      @result.errors += @form_object.errors.full_messages
    end
  end
end

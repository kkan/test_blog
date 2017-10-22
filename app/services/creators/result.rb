module Creators
  class Result
    attr_accessor :errors, :objects

    def initialize
      @errors = []
      @objects = {}
    end

    def success?
      errors.empty?
    end
  end
end

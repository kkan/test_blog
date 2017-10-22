class ObjectCreator
  attr_reader :result

  def initialize(form_object)
    @form_object = form_object
  end

  def process
    @result = Result.new
  end
end

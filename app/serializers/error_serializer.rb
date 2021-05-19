class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  set_type :error
  def as_json(_options = nil)
    {
      error: @instance_options[:error]
    }
  end

end

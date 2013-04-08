module RequestMacros
  def last_json
    return @_last_json if @_last_json_id == last_response.object_id
    @_last_json_id = last_response.object_id
    @_last_json = last_response.body.length > 0 ? MultiJson.load(last_response.body) : nil
  rescue MultiJson::LoadError
    raise "Failed to parse JSON:\n\n#{last_response.body}"
  end
end

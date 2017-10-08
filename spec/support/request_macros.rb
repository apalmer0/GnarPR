module RequestMacros
  def json_headers
    { "ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
  end

  def json_response(response)
    JSON.parse(response.body)
  end
end

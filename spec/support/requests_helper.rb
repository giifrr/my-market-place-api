# frozen_string_literal: true

module RequestsHelper
  def response_json
    JSON.parse(response.body)
  end
end

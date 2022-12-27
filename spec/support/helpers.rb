# frozen_string_literal: true

module Helpers
  def response_json_is_paginate
    expect(response_json.dig(:links, :first)).to_not be_nil
    expect(response_json.dig(:links, :last)).to_not be_nil
    expect(response_json.dig(:links, :prev)).to_not be_nil
    expect(response_json.dig(:links, :next)).to_not be_nil
  end
end

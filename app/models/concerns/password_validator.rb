# frozen_string_literal: true

require 'English'
class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    lower_case = 'abcdefghijklmnopqrstuvwxyz'
    upper_case = lower_case.upcase
    special_char = "~@#{$PROCESS_ID}%^&*()_+=-}{][;:'.><,"
    numbers = '0123456789'
    check = [0, 0, 0, 0]

    value.each_char do |chr|
      check[0] = 1 if lower_case.include?(chr)
      check[1] = 1 if upper_case.include?(chr)
      check[2] = 1 if numbers.include?(chr)
      check[3] = 1 if special_char.include?(chr)
    end

    if check.include?(0)
      record.errors.add attribute,
                        (options[:message] || 'Password must be at least upper case, lower case, special characters, and numbers')
    end
  end
end

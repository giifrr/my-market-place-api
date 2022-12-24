# frozen_string_literal: true

class Placement < ApplicationRecord
  belongs_to :order
  belongs_to :product, inverse_of: :placements
end

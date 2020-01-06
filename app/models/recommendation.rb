class Recommendation < ApplicationRecord
  acts_as_votable
  belongs_to :stock
end

class Foot < ActiveRecord::Base
  def self.belongs_to_quadriped?
    self.count == 4
  end
end

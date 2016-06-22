class Foot < ActiveRecord::Base
  def self.belongs_to_quadruped?
    self.count == 4
  end
end

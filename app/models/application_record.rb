class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.output_csv
    require 'csv'
    CSV.open("#{self.to_s.underscore}_output.csv", "w") do |row|
      keys = self.attribute_names
      row << keys
      self.pluck(keys).each {|e| row << e}
    end
  end
end

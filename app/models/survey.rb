class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessible :name

  def self.main_survey
    Survey.find_by_name('Principal')
  end

end

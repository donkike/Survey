class Question < ActiveRecord::Base
  
  #DATABASE RELATIONS
  has_many :answers, :order => 'number', :dependent => :destroy
  has_many :subquestions, :dependent => :destroy
  has_one :question_scale, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true
  belongs_to :aspect
  belongs_to :survey
  attr_accessible :number, :description, :aspect_id, :category, :survey_id

  def self.main_questions
    Survey.main_survey.questions
  end

end

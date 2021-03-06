# -*- coding: utf-8 -*-
class SurveysController < ApplicationController

  before_filter :user_logged?
  
  def index
    @surveys = Survey.all
  end
  
  def show    
    @survey = Survey.find(params[:id])    
  end

  def begin
    session[:answers] = []
    survey = Survey.find(params[:id])
    question = Question.all(:conditions => {:survey_id => survey.id}, :order => 'number')
    redirect_to question_path(question.first)
  end
  
  def assign_answer_to(question)
    session[:answers][question.number-1] = params[:answer]
  end

  def next_question_of(question)
    Question.find(:conditions => {:number => (question.number+1), :survey_id => question.survey_id})
  end

  def new
    @survey = Survey.new
  end
  
  def create
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
end

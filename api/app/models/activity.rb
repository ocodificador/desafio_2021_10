class Activity < ApplicationRecord
  belongs_to :project

  validates_presence_of :name, message: "Nome da atividade não pode estar vazio"
  validates_presence_of :start_date, message: "Data de início precisa ser informada"
  validates_presence_of :end_date, message: "Não foi informada data de término"
  validate :check_dates
  
  private
      
  def check_dates
    return if end_date.blank? || start_date.blank?  
    if end_date < start_date
      errors.add(:end_date, "Data de término não pode ser menor que data de início")
    end

    return if project.blank?

    if start_date < project.start_date
      errors.add(:start_date, "Data de início da atividade não pode ser menor que data de início do projeto")
    end

    if end_date < project.start_date
      errors.add(:end_date, "Data de término da atividade não pode ser menor que data de início do projeto")
    end    
  end
end

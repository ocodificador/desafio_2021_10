class Project < ApplicationRecord
  has_many :activities

  validates_presence_of :name, message: "Nome do projeto não pode estar vazio"
  validates_presence_of :start_date, message: "Data de início precisa ser informada"
  validates_presence_of :end_date, message: "Não foi informada data de término"
  validate :end_date_after_start_date
  

  def delayed
    false
  end

  def finished
    activities.where(finished: true).count == activities.count
  end

  # sobrescrevo o as_json inserindo os dois novos 'campos' no resultado 
  # e também as atividades
  def as_json(options={})
      super(include: :activities, methods: [:delayed, :finished])
  end

  private
      
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?  
    if end_date < start_date
      errors.add(:end_date, "Data de término não pode ser menor que data de início")
    end
  end
end

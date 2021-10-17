class Project < ApplicationRecord
  # Talvez seja melhor mudar o migration e incluir on_delete: :cascade
  # Assim a exclusão das atividades será feita pelo próprio banco
  has_many :activities, dependent: :destroy
  
  accepts_nested_attributes_for :activities, allow_destroy: true

  validates_presence_of :name, message: "Nome do projeto não pode estar vazio"
  validates_presence_of :start_date, message: "Data de início precisa ser informada"
  validates_presence_of :end_date, message: "Não foi informada data de término"
  validate :end_date_after_start_date
  

  def delayed
    activities.where("end_date > ?", end_date).count > 0 
  end

  def complete
    if activities.count > 0
      (activities.where(finished: true).count.to_f / activities.count) * 100
    else
      0
    end
  end

  def finished
    complete == 100
  end

  # sobrescrevo o as_json inserindo os dois novos 'campos' no resultado 
  # e também as atividades
  def as_json(options={})
      super(include: :activities, methods: [:delayed, :complete, :finished])
  end

  private
      
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?  
    if end_date < start_date
      errors.add(:end_date, "Data de término não pode ser menor que data de início")
    end
  end
end

class Project < ApplicationRecord
    validates_presence_of :name, message: "Nome do projeto não pode estar vazio"
    validates_presence_of :start_date, message: "Data inicial do projeto precisa ser informada"
    validates_presence_of :end_date, message: "Não foi infomada data de término do projeto"
end

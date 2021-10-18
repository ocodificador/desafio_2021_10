require 'rails_helper'

RSpec.describe Project, type: :model do

  # Crio um projeto com valores esperados e algumas atividades
  before(:all) do
    @project = Project.create(
      name: "Projeto para testar o modelo",
      start_date: DateTime.now,
      end_date:  DateTime.now + 1.week
    )
    @project_id = @project.id

    @project.activities.create(
      name: "Atividade 1 do projeto",
      start_date: DateTime.now + 1,
      end_date:  DateTime.now + 1.week - 1,
      finished: true
    )

    @project.activities.create(
      name: "Atividade 2 do projeto",
      start_date: DateTime.now + 1,
      end_date:  DateTime.now + 1.week + 1
    )

  end

  it "Válido com atributos válidos" do
    expect(@project).to be_valid
  end

  it 'Pode ser lido' do
    expect(Project.find(@project.id)).to eq(@project)
  end

  it 'Pode ser alterado' do
    @project.update(name: "Project for testing the model")
    expect(Project.where(name: "Project for testing the model").last).to eq(@project)
  end

  it 'Possui atraso' do
    expect(@project.delayed).to be true
  end

  it 'Não está concluído' do
    expect(@project.complete).to be < 100
  end

  it "Inválido sem um nome" do
    @project.name = nil
    expect(@project).to_not be_valid
  end

  it "Inválido se a data final for menor que a inicial" do
    @project.end_date = @project.start_date - 1
    expect(@project).to_not be_valid
  end

  it "Inválido sem uma data inicial" do
    @project.start_date = nil
    expect(@project).to_not be_valid
  end

  it "Inválido sem uma data final" do
    @project.end_date = nil
    expect(@project).to_not be_valid
  end

  it 'Pode ser apagado' do
    @project.destroy
    expect(Project.where(id: @project.id).count).to eq(0)
  end

end

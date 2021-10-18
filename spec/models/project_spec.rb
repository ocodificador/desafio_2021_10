require 'rails_helper'

RSpec.describe Project, type: :model do

  # Zero a tabela e crio um projeto com valores esperados
  before(:all) do
    Project.delete_all
    @project = Project.create(
      name: "Projeto para testar o modelo",
      start_date: DateTime.now,
      end_date:  DateTime.now + 1.week
    )
  end

  it "Válido com atributos válidos" do
    expect(@project).to be_valid
  end

  it 'Pode ser lido' do
    expect(Project.find_by_name("Projeto para testar o modelo")).to eq(@project)
  end

  it 'Pode ser alterado' do
    @project.update(name: "Project for testing the model")
    expect(Project.find_by_name("Project for testing the model")).to eq(@project)
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

  # Obiviamente só funcionará se Project.delete_all tiver sido executado
  # no ínicio do teste e nenhuma outra instância da classe tenha sido criada
  it 'Testando se pode ser excluído' do
    @project.destroy
    expect(Project.count).to eq(0)
  end

end

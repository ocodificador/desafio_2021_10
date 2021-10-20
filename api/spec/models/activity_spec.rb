require 'rails_helper'

RSpec.describe Activity, type: :model do

  # Crio um projeto válido e uma atividade para testar
  before(:all) do
    @project = Project.create(
      name: "Projeto para testar atividades",
      start_date: DateTime.now,
      end_date:  DateTime.now + 1.week
    )

    @activity = @project.activities.create(
      name: "Atividade primeira do projeto",
      start_date: DateTime.now + 1,
      end_date:  DateTime.now + 1.week - 1
    )
  end

  it "Válida com atributos válidos" do
    expect(@activity).to be_valid
  end

  it 'Pode ser lida' do
    expect(@project.activities.find_by_name("Atividade primeira do projeto")).to eq(@activity)
  end

  it 'Pode ser alterada' do
    @activity.update(name: "Activity for testing purposes")
    expect(@project.activities.find_by_name("Activity for testing purposes")).to eq(@activity)
  end

  it "Inválida sem um nome" do
    @activity.name = nil
    expect(@activity).to_not be_valid
  end

  it "Inválida se a data final for menor que a inicial" do
    @activity.end_date = @activity.start_date - 1
    expect(@activity).to_not be_valid
  end

  it "Inválida se a data inicial for menor que a inicial do projeto" do
    @activity.end_date = @project.start_date - 1
    expect(@activity).to_not be_valid
  end

  it "Inválida se a data final for menor que a inicial do projeto" do
    @activity.end_date = @project.start_date - 1
    expect(@activity).to_not be_valid
  end

  it "Inválida sem uma data inicial" do
    @activity.start_date = nil
    expect(@activity).to_not be_valid
  end

  it "Inválida sem uma data final" do
    @activity.end_date = nil
    expect(@activity).to_not be_valid
  end

  it 'Pode ser apagada' do
    @activity.destroy
    expect(@project.activities.count).to eq(0)
  end

end

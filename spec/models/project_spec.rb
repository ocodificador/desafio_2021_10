require 'rails_helper'

RSpec.describe Project, type: :model do
  # Alimentando o objeto com valores válidos
  subject {
    described_class.new(
      name:  "Projeto para testar o modelo",
      start_date: DateTime.now,
      end_date:  DateTime.now + 7.week
    )
  }

  it "Válido com atributos válidos" do
    expect(subject).to be_valid
  end

  it "Inválido sem um nome" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "Inválido sem uma data inicial" do
    subject.start_date = nil
    expect(subject).to_not be_valid
  end

  it "Inválido sem uma data final" do
    subject.end_date = nil
    expect(subject).to_not be_valid
  end

  it "Inválido se a data final for menor que a inicial" do
    subject.end_date = subject.start_date - 1
    expect(subject).to_not be_valid
  end
end

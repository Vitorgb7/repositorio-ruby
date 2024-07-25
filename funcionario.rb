require_relative 'validacao_cpf'

class Funcionario
  attr_accessor :nome, :cpf, :endereco, :categoria, :salario

  def initialize(nome, cpf, endereco, categoria)
    @nome = nome
    self.cpf = cpf
    @endereco = endereco
    self.categoria = categoria
  end

  def cpf=(cpf)
    if ValidadorCPF.validar(cpf)
      @cpf = CPF.new(cpf).formatted
    else
      raise "CPF inválido."
    end
  end

  def categoria=(categoria)
    @categoria = categoria
    case categoria.downcase
    when 'gerente'
      @salario = '50%+'
    when 'funcionario comum'
      @salario = 1500
    when 'estagiario'
      @salario = '30%-'
    else
      raise "Categoria inválida. As categorias válidas são: Gerente, Funcionario Comum, Estagiario."
    end
  end

  def to_s
    "Nome: #{@nome}, CPF: #{@cpf}, Endereço: #{@endereco}, Categoria: #{@categoria}, Salário: #{@salario}"
  end
end

$itens = []
$proximo_id = 1

def criar(nome)
  item = { id: $proximo_id, nome: nome }
  $itens << item
  $proximo_id += 1
  puts "Item criado: #{item[:id]} - #{item[:nome]}"
end

def ler
  puts "Lista de itens:"
  $itens.each do |item|
    puts "#{item[:id]} - #{item[:nome]}"
  end
end

def atualizar(id, novo_nome)
  item = $itens.find { |item| item[:id] == id }
  if item
    item[:nome] = novo_nome
    puts "Item atualizado: #{item[:id]} - #{item[:nome]}"
  else
    puts "Item não encontrado."
  end
end

def deletar(id)
  item = $itens.find { |item| item[:id] == id }
  if item
    $itens.delete(item)
    puts "Item deletado: #{item[:id]} - #{item[:nome]}"
  else
    puts "Item não encontrado."
  end
end

def iniciar
  loop do
    puts "Escolha uma opção: (1) Criar (2) Ler (3) Atualizar (4) Deletar (5) Sair"
    opcao = gets.chomp.to_i

    case opcao
    when 1
      puts "Digite o nome do item:"
      nome = gets.chomp
      criar(nome)
    when 2
      ler
    when 3
      puts "Digite o ID do item a ser atualizado:"
      id = gets.chomp.to_i
      puts "Digite o novo nome do item:"
      novo_nome = gets.chomp
      atualizar(id, novo_nome)
    when 4
      puts "Digite o ID do item a ser deletado:"
      id = gets.chomp.to_i
      deletar(id)
    when 5
      puts "Saindo..."
      break
    else
      puts "Opção inválida."
    end
  end
end

iniciar
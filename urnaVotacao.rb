require 'csv'
require 'cpf_cnpj'

def validar_cpf(cpf)
  CPF.valid?(cpf)
end

def limpar_tela
  system('clear') || system('cls')
end

def menu_principal
  puts "Selecione uma das opções abaixo:"
  puts "1. Votar"
  puts "2. Resultado"
  puts "3. Sair"
  gets.chomp.to_i
end

def menu_candidatos
  loop do
    puts "Digite o número do candidato para votar:"
    puts "1. candidato a"
    puts "2. candidato b"
    puts "3. candidato c"
    puts "4. candidato d"
    puts "5. branco"
    puts "6. nulo"
    input = gets.chomp
    if input.match?(/^\d+$/)
      return input.to_i
    else
      puts "Entrada invalida. por favor, digite um número."
      sleep(2)
      limpar_tela
    end
  end
end

def votar(votos, cpfs_ja_votaram)
  puts "Digite seu CPF:"
  cpf = gets.chomp
  if validar_cpf(cpf)
    if cpfs_ja_votaram.include?(cpf)
      puts "Este CPF ja votou. Tente novamente com outro CPF."
      sleep(2)  
    else
      limpar_tela
      voto = menu_candidatos
      case voto
      when 1
        votos[:candidato_a] += 1
      when 2
        votos[:candidato_b] += 1
      when 3
        votos[:candidato_c] += 1
      when 4
        votos[:candidato_d] += 1
      when 5
        votos[:branco] += 1
      when 6
        votos[:nulo] += 1
      else
        puts "Voto invalido."
      end
      cpfs_ja_votaram << cpf
      puts "registrado com sucesso!"
      sleep(2) 
    end
  else
    puts "CPF invalido. Tente novamente."
    sleep(2)  
  end
end

def mostrar_resultados(votos)
  CSV.open("resultado.csv", "wb") do |csv|
    csv << ["Candidato", "Votos"]
    csv << ["candidato a", votos[:candidato_a]]
    csv << ["candidato b", votos[:candidato_b]]
    csv << ["Candidato C", votos[:candidato_c]]
    csv << ["candidato d", votos[:candidato_d]]
    csv << ["branco", votos[:branco]]
    csv << ["nulo", votos[:nulo]]
  end
  puts "Resultados salvos em resultado.csv"
  sleep(2)
end

votos = {
  candidato_a: 0,
  candidato_b: 0,
  candidato_c: 0,
  candidato_d: 0,
  branco: 0,
  nulo: 0
}

cpfs_ja_votaram = []

loop do
  limpar_tela
  case menu_principal
  when 1
    votar(votos, cpfs_ja_votaram)
  when 2
    mostrar_resultados(votos)
  when 3
    puts "encerrando a urna..."
    sleep(2)
    break
  else
    puts "Opção invalida. Tente novamente."
    sleep(2)  
  end
  puts "\nPressione Enter para continuar..."
  gets
end
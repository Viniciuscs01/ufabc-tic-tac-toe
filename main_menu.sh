function show_welcome_message() {
  echo 'BEM VINDO AO JOGO DA VELHA'
}

function get_game_mode() {
  echo 'Escolha um modo de jogo:
  1 - 1 Jogador (Seleção aleatório)
  2 - 1 Jogador (Seleção inteligente)
  3 - 2 Jogadores
  4 - Máquina x Máquina (Modo expectador)'

  read GAME_MODE
  
}

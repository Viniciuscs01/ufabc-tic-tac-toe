#Função responsável por exibir mensgem de boas vindas ao jogo
function show_welcome_message() {
  echo 'BEM VINDO AO JOGO DA VELHA'
}

#Função responsável por exibir opções de jogo
function get_game_mode() {
  echo 'Escolha um modo de jogo:
  1 - 1 Jogador (Seleção aleatório)
  2 - 1 Jogador (Seleção inteligente)
  3 - 2 Jogadores
  4 - Máquina x Máquina (Modo expectador)'

  read GAME_MODE  
}

#Função responsável por definir qual jogador será X e qual será O.
function set_white_and_black() {
  case $GAME_MODE in
1|2|3) get_player1_choice ;;
*) echo "Opcao Invalida!" ;;
esac
}

#Função responsável por solicitar ao usuário que informe se será X ou O. O jogador 2 será sempre o que o 1 não for.
function get_player1_choice(){
  echo "O Jogador 1 será X ou O (Pressione X ou O)?"

  read PLAYER_1

  if [[ PLAYER_1 -eq "X" ]]
  then
    PLAYER_2="O"
  else
    PLAYER_2="X"
  fi
}
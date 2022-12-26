#!/bin/bash
source /home/vinicius/ufabc/tic-tac-toe/main_menu.sh
source /home/vinicius/ufabc/tic-tac-toe/tic_tac_toe.sh

#Chamada à função que exibe a mensagem de boas vindas ao jogo (main_menu.sh)
show_welcome_message

#Chamada à função que exibe as opções de modo de jogo e espera que o usuário selecione uma opção (main_menu.sh)
get_game_mode

#Após selecionar o modo de jogo, se não for MAQ x MAQ (opção 4), é solicitado ao usuário se o Jogador 1 será X ou O.
if [[ $GAME_MODE -ne 4 ]]
then
  #Chamada ao método que define X ou O para os jogadores 1 e 2.
  set_white_and_black
else
  #Caso o jogo seja MAQ x MAQ, o jogador 1 será X e o 2 O
  PLAYER_1="X"
  PLAYER_2="O"
fi

#Método que inicia o jogo (tic_tac_toe.sh)
start_the_game
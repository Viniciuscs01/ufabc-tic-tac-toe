source /home/vinicius/ufabc/tic-tac-toe/display_game.sh
source /home/vinicius/ufabc/tic-tac-toe/utils.sh

#Variável global para controle do jogo
winner=false

#Array para controle das posições livres e preenchidas
tic_tac_toe=("" "" "" "" "" "" "" "" "")

#Váriavel para controle de jogadas
turn=1

#Função que verifica modo de jogo escolhido pelo usuário e chama a função correspondente
function start_the_game(){
  if [[ $GAME_MODE -eq 1 ]]
  then
    start_1player_random
  elif [[ $GAME_MODE -eq 2 ]]
  then
    start_1player_smart
  elif [[ $GAME_MODE -eq 3 ]]
  then
    start_2players
  else
    start_comp_x_comp
  fi
}

#Função que inicia o jogo para 1 jogador x máquina (seleção aleatória)
function start_1player_random(){
  
  #Loop inicial que popula array de posições livres. Como o jogo está começando, todas as posições estão livres.
  for (( i=0; i<9; i++ ))
  do
    if [[ ${tic_tac_toe[$i]} -eq "" ]]
    then
      tic_tac_toe[$i]=$((i + 1))
    fi
  done
  #Loop que controla o jogo enquanto não houver um vencedor
  while [[ $winner == false ]]
  do
    #Definindo por padrão que é a vez do jogador 1 
    player=1
    symbol=$PLAYER_1

    #Mudando o jogador, caso a variável de controle do jogo seja par
    if [[ $(($turn % 2)) -eq 0 ]]
    then
      player=2
      symbol=$PLAYER_2
    fi

    #Limpando a tela para que apenas a jogada atual seja exibida
    clear

    #Exibindo instruções ao jogador que deve jogar
    echo "Jogador ${player} (${symbol}), escolha a posição:"    

    #Chamando função responsável por exibir o jogo em seu status atual (Posições livres e preenchidas)
    display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}

    #Se for a vez do jogador 2, então a seleção da posição será aleatória
    if [[ $player == 2 ]]
    then
      #Definindo posição aleatória para jogada
      randomPos=${positions[$[$RANDOM % ${#positions[@]}]]}
      #Baseado na posição, é definida a escolha do usuário
      choice=$(($randomPos + 1))
    else
      #Caso seja a vez do jogador 1, é solicitado ao usuário que escolha a posição de jogada
      read choice
    fi

    #A posição do Array será sempre a escolha do usuário -1, já que as escolhas vão de 1 a 9 e o array de posições 0 a 8.
    position=$(($choice - 1))    

    #Prenchido do array na posição escolhida com o simbole (X ou O) referente a jogada do usuário
    tic_tac_toe[$position]=$symbol

    #Chamada a função que verifica se existe um vencedor, passando como parâmetro a jogada do usuário e o array que controla o jogo
    check_winner $symbol "${tic_tac_toe[@]}"

    #Rotina que verifica se existe um vencedor
    if [[ $WINNER_HORIZONTAL == true ]] || [[ $WINNER_VERTICAL == true ]] || [[ $WINNER_DIAGONAL == true ]]
    then

      #Caso exista um vencedor, é exibida uma mensagem.
      echo "
#####################
# JOGADOR ${player} GANHOU! #
#####################"

      #Além da mensagem é exibido o estado final do jogo
      display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}

      #Por fim é definido com true a variavel que controla as jogadas
      winner=true
    else
      #Caso não exista um vencedor, é declarado uma variável que controla se existem posições disponíveis para jogo (caso não existam, é declarado um empate)
      available_positions=false

      #Declaração do array de posições disponíveis
      positions=()

      #Loop que verificada jogadas e define posições disponíveis
      for (( i=0; i<9; i++ ))
      do
        if [[ ${tic_tac_toe[$i]} != "X" ]] && [[ ${tic_tac_toe[$i]} != "O" ]]
        then
          positions+=($i)
          available_positions=true
        fi
      done

      #Se não existem posições disponíveis, é declarado um empate.
      if [[ $available_positions == false ]]
      then
        echo "
##########
# EMPATE #
##########"

        break
      fi
    fi
    #Caso não exista um vencedor e ainda existam posições disponíveis, é incrementado 1 na variável que controla vez de cada jogador
    turn=$(($turn + 1))
  done
}

#Função que inicia o jogo para 1 jogador x máquina (seleção inteligente)
function start_1player_smart(){
  echo "${GAME_MODE}: Not implemented yet"
}

#Função que inicia o jogo para 2 jogadores
function start_2players(){
  for (( i=0; i<9; i++ ))
  do
    if [[ ${tic_tac_toe[$i]} -eq "" ]]
    then
      tic_tac_toe[$i]=$((i + 1))
    fi
  done

  while [[ $winner == false ]]
  do 
    player=1
    symbol=$PLAYER_1

    if [[ $(($turn % 2)) -eq 0 ]]
    then
      player=2
      symbol=$PLAYER_2
    fi

    clear
    echo "Jogador ${player} (${symbol}), escolha a posição:"    
    display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}

    #Diferente do modo de jogo 1 JOGADOR x MAQUINA, nesse modo é sempre solicitado ao usuário a escolha de jogada (Ja que é esse é o modo hum x hum)
    read choice
    position=$(($choice - 1))    
    tic_tac_toe[$position]=$symbol

    check_winner $symbol "${tic_tac_toe[@]}"

    if [[ $WINNER_HORIZONTAL == true ]] || [[ $WINNER_VERTICAL == true ]] || [[ $WINNER_DIAGONAL == true ]]
    then
      echo "
#####################
# JOGADOR ${player} GANHOU! #
#####################"

      display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}
      winner=true
    else
      available_positions=false

      for (( i=0; i<9; i++ ))
      do
        if [[ ${tic_tac_toe[$i]} != "X" ]] && [[ ${tic_tac_toe[$i]} != "O" ]]
        then
          echo "AVAILABLE"
          available_positions=true
        fi
      done

      if [[ $available_positions == false ]]
      then
        echo "
##########
# EMPATE #
##########"

        break
      fi
    fi
    turn=$(($turn + 1))
  done
}

#Função que inicia o jogo Maq x Maq
function start_comp_x_comp(){
  for (( i=0; i<9; i++ ))
  do
    positions+=($i)
    if [[ ${tic_tac_toe[$i]} -eq "" ]]
    then
      tic_tac_toe[$i]=$((i + 1))
    fi
  done

  while [[ $winner == false ]]
  do 
    player=1
    symbol=$PLAYER_1

    if [[ $(($turn % 2)) -eq 0 ]]
    then
      player=2
      symbol=$PLAYER_2
    fi

    clear
    echo "Jogador ${player} (${symbol}), escolha a posição:"    
    display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}

    #Neste a escolha é sempre aleatória e não existe interação com o usuário, que fica apenas de expectador
    randomPos=${positions[$[$RANDOM % ${#positions[@]}]]}
    choice=$(($randomPos + 1))
    
    position=$(($choice - 1))    
    tic_tac_toe[$position]=$symbol

    check_winner $symbol "${tic_tac_toe[@]}"

    if [[ $WINNER_HORIZONTAL == true ]] || [[ $WINNER_VERTICAL == true ]] || [[ $WINNER_DIAGONAL == true ]]
    then
      echo "
#####################
# JOGADOR ${player} GANHOU! #
#####################"

      display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}
      winner=true
    else
      available_positions=false
      positions=()
      for (( i=0; i<9; i++ ))
      do
        if [[ ${tic_tac_toe[$i]} != "X" ]] && [[ ${tic_tac_toe[$i]} != "O" ]]
        then
          positions+=($i)
          available_positions=true
        fi
      done

      echo "${positions[@]}"

      if [[ $available_positions == false ]]
      then
        echo "
##########
# EMPATE #
##########"
        display_game ${tic_tac_toe[0]} ${tic_tac_toe[1]} ${tic_tac_toe[2]} ${tic_tac_toe[3]} ${tic_tac_toe[4]} ${tic_tac_toe[5]} ${tic_tac_toe[6]} ${tic_tac_toe[7]} ${tic_tac_toe[8]}
        break
      fi
    fi
    turn=$(($turn + 1))
  done
}
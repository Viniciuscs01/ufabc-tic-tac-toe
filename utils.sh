#Função que verifica se existe um vencedor
function check_winner(){
  #Definição de uma váriavel local que recebe o simbolo jogado pelo usuário
  LOCAL_SYMBOL=$1
  shift

  #Definição de uma variável local que recebe o array que controla o jogo
  LOCAL_TIC_TAC_TOE=("$@")
  
  #Chamadas às funções que verificam as horizontais, verticais e diagonais
  check_horizontais
  check_verticais
  check_diagonais
}

function check_horizontais(){
  WINNER_HORIZONTAL=false

  #Loop que verifica as linhas, que iniciam no indices 0, 3 e 6 (por isso i + 3).
  for (( i=0; i<9; i=$((i + 3)) ))
  do
    if [[ ${LOCAL_TIC_TAC_TOE[$i]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[$(($i + 1))]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[$(($i + 2))]} == $LOCAL_SYMBOL ]]
    then
      WINNER_HORIZONTAL=true
    fi
  done
}

function check_verticais() {
  WINNER_VERTICAL=false

  #Loop que verifica as colunas, que iniciam no indices 0, 1 e 2 (por isso i++).
  for (( i=0; i<3; i++ ))
  do
    if [[ ${LOCAL_TIC_TAC_TOE[$i]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[$(($i + 3))]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[$(($i + 6))]} == $LOCAL_SYMBOL ]]
    then
      WINNER_VERTICAL=true
    fi
  done
}

function check_diagonais() {
  WINNER_DIAGONAL=false

  #Rotina que verifica diagonais com indices fixos, já que existem apenas 2 possibilidades: (0, 4, 8) e (2, 4, 6).
  if ([[ ${LOCAL_TIC_TAC_TOE[0]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[4]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[8]} == $LOCAL_SYMBOL ]]) || 
     ([[ ${LOCAL_TIC_TAC_TOE[2]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[4]} == $LOCAL_SYMBOL ]] && [[ ${LOCAL_TIC_TAC_TOE[6]} == $LOCAL_SYMBOL ]])
  then
    WINNER_DIAGONAL=true
  fi
}
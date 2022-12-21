#!/bin/bash
source /home/vinicius/ufabc/tic-tac-toe/main_menu.sh
source /home/vinicius/ufabc/tic-tac-toe/display_game.sh
show_welcome_message
get_game_mode
echo $GAME_MODE
display_game
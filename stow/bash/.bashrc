#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/bash/aliases
source ~/.config/bash/envs
source ~/.config/bash/evals
source ~/.config/bash/path

PS1='[\u@\h \W]\$ '

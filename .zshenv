export PATH=$PATH:/bin
export LANG=ja_JP.UTF-8
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
setopt prompt_subst
setopt correct
setopt nolistbeep
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt transient_rprompt
unsetopt caseglob
bindkey -v
autoload -U compinit; compinit
autoload zmv
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
alias zmv='noglob zmv -W'
export PATH=$HOME/.local/bin:$PATH
export KEYTIMEOUT=1
export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export HISTFILE=~/.zhistory
export SAVEHIST=100
export GREP_OPTIONS='--color=never'
EMOJI_YES=$'\u2B55 '
EMOJI_NO=$'\u274C '
EMOJI_ABORT=$'\U1F44B '
EMOJI_EDIT=$'\u26D4 '
KAOMOJI_SUCCEED="(๑･𝗏･)و"$'\u2728 '
KAOMOJI_FAIL="(๑>﹏<%)"$'\U1F32A '
KAOMOJI_SUGGEST="(๑'~'%)"$'\u2753 '
function zle-line-init zle-keymap-select {
  PROMPT="%(?!%F{216}!%F{151})%(?!${KAOMOJI_SUCCEED}!${KAOMOJI_FAIL})@%~::%f"
  case $KEYMAP in
    vicmd)
    PROMPT=$PROMPT"%F{192}%BNormal%b%f< "
    ;;
    main|viins)
    PROMPT=$PROMPT"%F{202}%BInsert%b%f< "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

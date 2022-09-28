# シェルの再起動
alias relogin='exec $SHELL -l'

# docker
# 不要なイメージの削除
alias docker-clean="docker images | awk '/<none/{print $3}' | xargs docker rmi"
# 起動中のコンテナを全て停止する
# 起動中のコンテナを全て停止する
function d-stop () {
  docker stop $(docker ps -q)
}
 alias d-stop=d-stop

# git
# いつものやつら
alias gb='git branch'
alias gs='git switch $1'
alias gsc='git switch -c $1'
# 部分一致でswitch
function gsg () {
  git switch $(git branch | grep $1)
}
alias gsg=gsg

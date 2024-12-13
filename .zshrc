PROMPT="%~ $ "

# シェルの再起動
alias relogin='exec $SHELL -l'

# 指定したポートのプロセスを全て停止
# 引数にはセミコロンとポートを指定
alias akill='kill -9 $(lsof -ti $i)'

# docker
# コンテナの停止
alias dc-stop='docker-compose stop'
# 不要なイメージの削除
alias d-clean="docker images | awk '/<none/{print $3}' | xargs docker rmi"
# 起動中のコンテナを全て停止する
function d-stopa () {
  docker stop $(docker ps -q)
}
alias d-stopa=d-stopa

# git
alias gb='git branch'
alias gsw='git switch'
alias gst='git stash'
alias gps='git push'
alias gpl='git pull'
alias gm='git merge'
# ブランチの発行
alias gpshoh='gps -u origin HEAD'
# 部分一致でswitch
function gsg () {
  git switch $(git branch | grep $1)
}
alias gsg=gsg
# gitのキャッシュをクリアして.gitignoreに追加した項目を適用
alias gcc='git rm -r --cached . && git add .'

# Xcode - DerivedDataDelete
alias ddd='sudo rm -rf ~/Library/Developer/Xcode/DerivedData'

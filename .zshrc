PROMPT="%F{cyan}[%D{%Y-%m-%d %H:%M:%S}]%f
%~ 👉 "

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
alias gs='git switch'
alias gps='git push'
alias gpl='git pull'
alias gm='git merge'
alias gst='git stash'
alias gstp='gst pop'
# ブランチの発行
alias gpshoh='gps -u origin HEAD'
# 部分一致でswitch
function gsg () {
  git switch $(git branch | grep $1)
}
alias gsg=gsg
# キャッシュをクリアして .gitignore に追加した項目を適用
alias gcc='git rm -r --cached . && git add .'
# remote で merged になり削除された local の branch を削除
alias gbc='git fetch --prune && git branch -vv | grep ": gone]" | awk "{print \$1}" | xargs -r git branch -D'
# force pull
alias gfpl='git fetch origin && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
# 全 branch を pull（失敗した　 branch を最後に報告）
function gplall() {
  local failed=()
  local current=$(git rev-parse --abbrev-ref HEAD)
  for b in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
    git switch $b >/dev/null 2>&1
    if ! git pull; then
      failed+=($b)
    fi
  done
  git switch $current >/dev/null 2>&1
  if [ ${#failed[@]} -ne 0 ]; then
    echo "以下のブランチはリモートと整合性が取れずローカルを最新化できませんでした: ${failed[@]}"
  fi
}
alias gplall=gplall
# gitコマンドのtab補完
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    autoload -Uz compinit
    compinit
fi

# AWS CLI
alias ec2ls='aws ec2 describe-instances --query "Reservations[].Instances[].{InstanceId: InstanceId, Name: Tags[?Key==\`Name\`]|[0].Value, State: State.Name}" --output table'
alias ec2run='aws ec2 start-instances --instance-ids'
alias ec2stop='aws ec2 stop-instances --instance-ids'

# ~/.zshrc の変更内容を適用する
alias sz='source ~/.zshrc'
# ~/.zshrc を vi で開く
alias vz='sudo vi ~/.zshrc'

# QuickTime で画面収録した mov を全て mp4 に変換して mov を削除
alias mov2mp4='cd ~/Desktop && for file in *.mov; do ffmpeg -i "$file" -c:v libx264 -c:a aac "${file%.mov}.mp4" && rm "$file"; done && cd -'

# カレントディレクトリの PDF の全てのページを png に変換し、同名のフォルダを作成して格納
convert_pdfs() {
  for pdf in ./*.pdf; do
    [[ -f "$pdf" ]] || continue
    base="${pdf%.pdf}"
    mkdir -p "$base"
    pdftoppm -png "$pdf" "$base/$base"
    echo "Converted $pdf → $base/"
  done
}
alias pdf2png=convert_pdfs

# Claude Code
# monitoring
alias cm="claude-monitor --timezone Asia/Tokyo"
# launch
alias cc="claude --enable-auto-mode"

# Xcode - DeleteDerivedData
alias ddd='sudo rm -rf ~/Library/Developer/Xcode/DerivedData'

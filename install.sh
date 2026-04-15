#!/bin/bash
# install.sh — 新規 Mac に dotfiles をセットアップするスクリプト
# 使い方: bash install.sh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log()  { echo -e "${GREEN}✔${NC}  $1"; }
info() { echo -e "${CYAN}→${NC}  $1"; }
warn() { echo -e "${YELLOW}⚠${NC}  $1"; }

# ── シンボリックリンクを作成（既存ファイルはバックアップ） ────────────────────
symlink() {
  local src="$1"   # dotfiles 内のパス
  local dest="$2"  # リンク先 (~/ 以下)

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" ]]; then
    warn "スキップ（既にリンク）: $dest"
    return
  fi

  if [[ -e "$dest" ]]; then
    local bak="${dest}.bak.$(date +%Y%m%d_%H%M%S)"
    warn "バックアップ: $dest → $bak"
    mv "$dest" "$bak"
  fi

  ln -s "$src" "$dest"
  log "リンク作成: $dest → $src"
}

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   dotfiles install script                  ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 1. Homebrew
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
info "Homebrew を確認中..."
if ! command -v brew &>/dev/null; then
  info "Homebrew をインストール中..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon / Intel 両対応
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  log "Homebrew インストール完了"
else
  log "Homebrew はインストール済み"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 2. Homebrew パッケージ
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
info "パッケージをインストール中..."

FORMULAS=(git vim ffmpeg poppler)
CASKS=(wezterm visual-studio-code font-jetbrains-mono)

brew tap homebrew/cask-fonts 2>/dev/null || true

for f in "${FORMULAS[@]}"; do
  brew list --formula "$f" &>/dev/null || brew install "$f"
  log "$f"
done

for c in "${CASKS[@]}"; do
  brew list --cask "$c" &>/dev/null || brew install --cask "$c"
  log "$c"
done

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 4. dotfiles シンボリックリンク
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
info "dotfiles をリンク中..."

symlink "$DOTFILES_DIR/.zshrc"               "$HOME/.zshrc"
symlink "$DOTFILES_DIR/.vimrc"               "$HOME/.vimrc"
symlink "$DOTFILES_DIR/.wezterm.lua"         "$HOME/.wezterm.lua"
symlink "$DOTFILES_DIR/.vscode/settings.json" "$HOME/.vscode/settings.json"
symlink "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 5. 完了
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   完了！                                   ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "  次のステップ:"
echo "  1. source ~/.zshrc   ← zsh 設定を即時適用"
echo "  2. WezTerm を再起動"
echo "  3. VS Code を再起動"
echo ""

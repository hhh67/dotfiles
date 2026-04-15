# dotfiles

macOS 向け個人設定ファイル群。`install.sh` 一発で Homebrew・パッケージのインストールとシンボリックリンクの作成まで完結する。

## 管理対象

| ファイル | 用途 |
|---|---|
| `.zshrc` | Zsh 設定 |
| `.vimrc` | Vim 設定 |
| `.wezterm.lua` | WezTerm 設定（日本語入力対応含む） |
| `.vscode/settings.json` | VS Code 設定 |
| `.claude/settings.json` | Claude Code 設定 |

## インストール

```sh
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
bash install.sh
```

インストール内容:
- **Homebrew** （未導入なら自動インストール）
- **Formulae**: `git`, `vim`, `ffmpeg`, `poppler`
- **Casks**: `wezterm`, `visual-studio-code`, `font-jetbrains-mono`
- 各設定ファイルのシンボリックリンク（既存ファイルは `.bak` でバックアップ）

完了後は `source ~/.zshrc` を実行し、WezTerm / VS Code を再起動する。

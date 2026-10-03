# macOS dotfiles

Ansible を使って macOS の開発環境、fish、ウィンドウ管理ツールをセットアップします。

## 実行方法

macOS と Homebrew を用意し、`ansible-playbook` と `community.general` collection が利用できる状態でリポジトリのルートから実行してください。Playbook 自身も Ansible をインストールしますが、初回起動には Ansible が必要です。

```sh
ansible-playbook --syntax-check -i localhost, playbook.yml
ansible-playbook -i localhost, playbook.yml
```

初回は fish をログインシェルとして登録するため、管理者認証が必要です。認証を求められた場合は次のように実行してください。

```sh
ansible-playbook -i localhost, playbook.yml --ask-become-pass
```

ログインシェルの変更は新しいターミナルまたは再ログイン後に反映されます。

## Playbook の内容

| Role | 内容 |
| --- | --- |
| `devtools` | Homebrew の git/mise、mise の Node.js・uv・Python、uv 経由の Ansible、npm 経由の OpenCode CLI を管理します。zsh の既存設定も維持します。 |
| `fish` | fish をインストールし、リポジトリの `fish/config.fish` を `~/.config/fish/config.fish` にリンクします。fish をログインシェルに設定します。 |
| `window_manager` | yabai と skhd をインストールし、設定を `~/.config/` にリンクしてサービスを起動します。 |

fish の設定には zsh の起動設定を引き継いでいます。

- `~/.zprofile`: Homebrew の shell environment
- `~/.zshenv`: `~/.local/bin` を PATH に追加
- `~/.zshrc`: mise を有効化

既存の zsh 設定ファイルは削除・変更せず、fish 用設定を別途管理します。

## yabai / skhd

`yabairc` は SIP を無効化せず、scripting addition を使わない bsp レイアウト設定です。キーバインドは `skhdrc` にあり、Option/Alt と h/j/k/l でウィンドウを操作します。

macOS の「システム設定 > プライバシーとセキュリティ > アクセシビリティ」で yabai と skhd の許可が必要です。

## 補足

- `jdx/mise` の Homebrew tap が利用可能な場合は追加します。利用できない場合は Homebrew core の mise formula を使います。
- Homebrew がサードパーティの yabai/skhd formula を信頼対象として要求する環境では、対象 formula のみを trust します。
- Ansible は要件に合わせて `uv tool install --force ansible-core --with ansible` でインストールします。

# Agent instructions

このリポジトリは macOS の dotfiles と Ansible による環境構築を管理します。

## 変更時のルール

- 新しいセットアップ処理は既存構成に沿って `roles/<role>/tasks/main.yml` に追加し、`playbook.yml` から呼び出してください。
- Ansible タスクは再実行可能にしてください。コマンドを使う場合は、必要に応じて `when`、`creates`、`changed_when`、`failed_when` を設定してください。
- ホームディレクトリへ直接設定を複製せず、リポジトリ内の設定を管理し、role からシンボリックリンクしてください。
- fish の起動設定は `fish/config.fish` で管理します。zsh の既存設定を引き継ぐ変更では fish 側との整合性を保ち、既存の `~/.zsh*` ファイルは削除しないでください。
- `yabairc` は実行可能な `0755` を維持してください。SIP を無効化したり yabai scripting addition を前提にしたりしないでください。
- Homebrew tap や formula の提供状況は変化します。`jdx/mise` が利用できない場合は現在の role と同様に core formula へフォールバックしてください。
- ユーザーから明示的に依頼されない限り、commit や push は行わないでください。

## 検証

変更後は少なくとも次を実行してください。

```sh
ansible-playbook --syntax-check -i localhost, playbook.yml
git diff --check
```

ローカル macOS への適用確認が必要な変更では、次も実行します。

```sh
ansible-playbook -i localhost, playbook.yml
```

fish の設定を変更した場合は `fish -n fish/config.fish` でも構文を確認してください。初回のログインシェル設定など、管理者権限が必要な場合は `--ask-become-pass` を使用します。

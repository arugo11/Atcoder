#!/bin/bash

# テスト実行
ojt() {
    local file="${1:-a}.py"  # デフォルトは a.py
    oj t -c "python3 $file"
}

# 提出
ojs() {
    if [ $# -lt 2 ]; then
        echo "Usage: ojs <contest_id> <problem_id>"
        echo "Example: ojs abc386 a"
        return 1
    fi
    local contest_id=$1
    local problem_id=$2
    
    # カレントディレクトリのファイルを提出
    if oj s "https://atcoder.jp/contests/$contest_id/tasks/${contest_id}_$problem_id" "${problem_id}.py" -l 5055; then
        handle_submit "$contest_id" "$problem_id"
    fi
}

# テストして提出
ojts() {
    if [ $# -lt 2 ]; then
        echo "Usage: ojts <contest_id> <problem_id>"
        echo "Example: ojts abc386 a"
        return 1
    fi
    local contest_id=$1
    local problem_id=$2
    
    if ojt "$problem_id" && ojs "$contest_id" "$problem_id"; then
        echo "Test passed, submitted, and committed!"
    else
        echo "Something went wrong"
    fi
}

# サンプルケースのダウンロード
ojd() {
    if [ $# -lt 1 ]; then
        echo "Usage: ojd <url>"
        echo "Example: ojd https://atcoder.jp/contests/abc386/tasks/abc386_a"
        return 1
    fi
    oj d "$1"
}

# 以下、新機能の追加

# コンテストの準備（ブランチ作成とディレクトリ設定）
setup_contest() {
    if [ $# -lt 1 ]; then
        echo "Usage: setup_contest <contest_id>"
        return 1
    fi
    local contest_id=$1
    
    # mainブランチから新しいブランチを作成
    git checkout main
    git pull origin main
    git checkout -b $contest_id
    
    # コンテストディレクトリの作成
    acc new $contest_id
    cd $contest_id
    
    # READMEの更新
    update_readme $contest_id
}
# READMEの更新
update_readme() {
    local contest_id=$1
    local readme_path=~/atcoder/README.md
    
    # コンテストセクションが無ければ追加
    if ! grep -q "## ${contest_id^^}" $readme_path; then
        echo -e "\n## ${contest_id^^}\n" >> $readme_path
        echo "| Problem | Solution | Notes |" >> $readme_path
        echo "|----------|----------|-------|" >> $readme_path
    fi
}

# 提出成功時の処理
handle_submit() {
    local contest_id=$1
    local problem_id=$2

    # 現在のブランチを確認
    local current_branch=$(git -C ~/atcoder branch --show-current)

    # gitコミット
    git -C ~/atcoder add "abc/${contest_id}/${problem_id}/${problem_id}.py"
    git -C ~/atcoder commit -m "submit: ${contest_id^^} ${problem_id^^} - Submitted during contest"

    # mainブランチの場合はpushしない
    if [ "$current_branch" != "main" ]; then
        git -C ~/atcoder push origin "$current_branch"
    fi

    # issueの作成と README の更新
    create_problem_issue "$contest_id" "$problem_id"
}
# issueの作成
create_problem_issue() {
    local contest_id=$1
    local problem_id=$2

    # issue templateの作成
    local title="[${contest_id^^} ${problem_id^^}] Solution Discussion"
    local body="## 問題概要

## 解法

## 学んだこと

## 参考"

    # GitHub CLIでissue作成
    issue_url=$(gh issue create --title "$title" --body "$body" --repo "$(git remote get-url origin)")

    # READMEの更新
    update_readme_with_issue $contest_id $problem_id $issue_url
}
# コンテスト終了時の処理
finish_contest() {
    local contest_id=$1
    
    # PRの作成
    gh pr create --base main --head $contest_id \
        --title "Contest ${contest_id^^} Solutions" \
        --body "Solutions and notes for ${contest_id^^}"
}

# READMEの問題情報更新
update_readme_with_issue() {
    local contest_id=$1
    local problem_id=$2
    local issue_url=$3
    local readme_path=~/atcoder/README.md

    # 問題の行を追加
    echo "| ${problem_id^^} | [solution](abc/${contest_id}/${problem_id}/${problem_id}.py) | [notes](${issue_url}) |" >> $readme_path
}

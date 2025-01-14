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
        # 提出成功したらgitコミット
        git -C ~/atcoder add "abc/${contest_id}/${problem_id}/${problem_id}.py"
        git -C ~/atcoder commit -m "solve: ${contest_id}_${problem_id}"
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

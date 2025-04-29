#!/bin/bash

start_date="2021-07-04"
end_date=$(date +%Y-%m-%d)

current_date="$start_date"

while [ "$current_date" != "$end_date" ]; do
  # Verifica se é domingo (0 = domingo)
  day_of_week=$(date -d "$current_date" +%w)
  if [ "$day_of_week" -ne 0 ]; then
    echo "Commit on $current_date" > commit.md

    export GIT_COMMITTER_DATE="$current_date 12:00:00"
    export GIT_AUTHOR_DATE="$current_date 12:00:00"

    git add commit.md -f
    git commit --date="$current_date 12:00:00" -m "Commit on $current_date"
  fi

  # Avança para o próximo dia
  current_date=$(date -I -d "$current_date + 1 day")
done

# Push final
git push origin main

# Commit de limpeza (opcional)
echo "" > commit.md
git commit -am "Cleanup"
git push origin main

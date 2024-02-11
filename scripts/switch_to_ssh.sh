#!/bin/bash
echo -n "Enter your github Username: "
read USERNAME
echo -n "Enter the Directory to run from: "
read start_dir

for DIR in $(find $start_dir -type d); do
  if [ -d "$DIR/.git" ] || [ -f "$DIR/.git" ]; then
    (
      cd "$DIR"
      REMOTE=$(git config --get remote.origin.url)
      REPO=$(basename "`git rev-parse --show-toplevel`")

      if [[ "$REMOTE" == "https://github.com/"* ]]; then
        echo "HTTPS repo found ($REPO) $DIR"
        git remote set-url origin git@github.com:$USERNAME/$REPO

        # Check if the conversion worked
        REMOTE=$(git config --get remote.origin.url)
        if [[ "$REMOTE" == "git@github.com:"* ]]; then
          echo "Repo \"$REPO\" converted successfully!"
        else
          echo "Failed to convert repo $REPO from HTTPS to SSH"
        fi
      elif [[ "$REMOTE" == "git@github.com:"* ]]; then
        echo "SSH repo - skip ($REPO) $DIR"
      else
        echo "Not Github - skip ($REPO) $DIR"
      fi
    )
  fi
done


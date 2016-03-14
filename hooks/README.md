To enable M-Lab,github.io's git hooks in your git repo, run the following from the
repo root:

`rm -rf .git/hooks/ && ln -s -f ../hooks .git/`
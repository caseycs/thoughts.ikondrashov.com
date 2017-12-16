#!/bin/sh -ex

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
#    exit 1;
fi

echo "Deleting old publication"
rm -rf docs
mkdir docs
git worktree prune
rm -rf .git/worktrees/docs/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages docs origin/gh-pages

echo "Removing existing files"
rm -rf docs/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd docs && git add --all && git commit -m "Publishing to gh-pages (publish_to_ghpages.sh)" && git push -f origin gh-pages
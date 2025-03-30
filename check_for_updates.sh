#!/bin/bash

cd /home/ofir/myapp/test-repo

git fetch

if ! git diff --quiet HEAD..origin/ofir; then
    echo "update detected. Pulling and restarting service..."
    git pull
    sudo systemctl restart myapp.service

    echo "$(cat version) - $(date)" >> /home/ofir/myapp/test-repo/ofir_dates.txt

    git add ofir_dates.txt
    git commit -m "Log update at $(date)"
    git push
else
    echo "no updates found"
fi


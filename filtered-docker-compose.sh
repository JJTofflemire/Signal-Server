#!/bin/bash

docker compose up --no-log-prefix | awk '{gsub(/WARN /, "\033[33m&\033[0m"); gsub(/ERROR/, "\033[31m&\033[0m"); gsub(/INFO/, "\033[32m&\033[0m"); print}' | sed '/Timing: [0-9]\+ ms/,/<\/html>/d; /^$/d'
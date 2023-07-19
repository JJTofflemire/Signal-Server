#!/bin/bash

docker compose up 2>&1 --no-log-prefix | grep -v -e "Timing:" -e "Status:" -e "html" -e "meta" -e "<title>" -e "960 stuff:" -e " reset " -e " text " -e "height" -e "end 960" -e "body {" -e "color:" -e "background:" -e "min-width:" -e "padding:" -e "border-bottom" -e " 		}" -e "vertical-align:" -e "margin:" -e "display:" -e "* {" -e "data." -e "document."

docker compose down
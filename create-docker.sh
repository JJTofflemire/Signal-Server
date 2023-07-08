#!/bin/bash

docker rmi signal-server

docker build --no-cache -t signal-server .
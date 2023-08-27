#!/bin/bash

# version 0.0.5
echo "Linux Server Manager"

serverPath="replaceme"
configPath="replaceme"

echo "Available commands: 'bebo start', 'bebo stop', 'bebo restart'."

if [[ ! -f "$serverPath" ]]; then
    echo "server path is not set or does not exist."
    exit 1
fi

if [[ ! -f "$configPath" ]]; then
    echo "config path is not set or does not exist."
    exit 1
fi

alreadyRunning() {
    pgrep -f "$serverPath" > /dev/null
}

startServer() {
    echo "server started"
    xterm -e "$serverPath +exec $configPath" &
}

stopServer() {
    echo "server stopped"
    pkill -f ./run.sh
    sleep 5
}

restartServer() {
    stopServer
    startServer
}

while true; do
    read -p "" command
    
    case "$command" in
        "bebo start")
            if alreadyRunning; then
                echo "server is already running."
            else
                startServer
            fi
            ;;
        "bebo stop")
            if alreadyRunning; then
                stopServer
            else
                echo "server is not running."
            fi
            ;;
        "bebo restart")
            if alreadyRunning; then
                restartServer
            else
                echo "server is not running. starting now..."
                startServer
            fi
            ;;
        *)
            echo "unknown command"
            ;;
    esac
done
#!/bin/bash

# Created by Varrxy

INCREMENT=10

case "$1" in
    --inc) brightnessctl set ${INCREMENT}%+ ;;
    --dec) brightnessctl set ${INCREMENT}%- ;;
    *) echo "Usage: $0 --inc | --dec"; exit 1 ;;
esac

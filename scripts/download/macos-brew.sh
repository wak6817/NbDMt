#!/bin/sh

echo "Make sure you have Brew installed, you can download brew here: https://www.brew.sh"

brew update && brew upgrade
brew install git python3 npm node # Clang is pre-installed

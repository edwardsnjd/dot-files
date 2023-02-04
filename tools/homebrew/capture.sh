#!/usr/bin/env bash

rm Brewfile*
brew bundle dump
brew bundle install

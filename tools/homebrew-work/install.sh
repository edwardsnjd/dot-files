#!/usr/bin/env bash

function Main() {
  brew bundle install
  AwsSamCli
}

function AwsSamCli() {
  # See: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/reference-sam-cli-install-verify.html
  # See: https://github.com/aws/aws-sam-cli

  local packageUrl="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-macos-arm64.pkg"
  local packagePath="aws-sam-cli-macos-arm64.pkg"
  local expectedFingerprint="49 68 39 4A BA 83 3B F0 CC 5E 98 3B E7 C1 72 AC 85 97 65 18 B9 4C BA 34 62 BF E9 23 76 98 C5 DA"

  # Download and install
  echo "Downloading AWS SAM CLI installer: $packageUrl"
  curl -L "$packageUrl" --output "$packagePath"

  # Verify package download
  echo "Verifying AWS SAM CLI installer: $packageUrl"
  pkgutil --check-signature "$packagePath" \
    | tr -d "\n" \
    | sed -E 's/ +/ /g' \
    | grep -q "$expectedFingerprint" \
    && echo "AWS SAM CLI package signatures look OK" \
    || { echo "AWS SAM CLI package signatures look BAD!"; exit 1; }

  # Install
  echo "Installing AWS SAM CLI: $packageUrl"
  sudo installer -pkg "$packagePath" -target "/"

  # Clean up
  echo "Deleting AWS SAM CLI installer: $packagePath"
  rm "$packagePath"

  # Confirm installed ok
  which sam
  sam --version
}

Main "$@"

#!/usr/bin/env bash

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  typing=$(cat $typing)
  echo "${BOL_RED}Message:${BOL_YEL}${msg}${END}"
}

function cm() {
  translate
  if [[ ${1} ]]; then
    git commit --author "${1}" --date "$(date)"
  else
    git commit --message $msg --signoff --author "kleidione Freitas <kleidione@gmail.com>" --date "$(date)"
  fi
}

function amend() {
  if [[ ${1} ]]; then
    git commit --author "${1}" --signoff --amend --date "$(date)"
  else
    git commit --signoff --amend --date "$(date)"
  fi
}

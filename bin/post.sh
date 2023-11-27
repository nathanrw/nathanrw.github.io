#!/bin/bash

ME="$(basename "$0")"

usage() {
  cat <<EOF
$ME <name>

Starts a new post.
EOF
}

error() {
  >&2 echo "$@"
  exit 1
}

maketext() {
  name="$1"
  now="$2"
  if [[ -z "$name" ]]; then
    error "maketext <name> <now>"
  fi
  if [[ -z "$now" ]]; then
    error "maketext <name> <now>"
  fi
  cat <<EOF
+++
title = "$name"
date = "$now"
sorted_by = "date"
[taxonomies]
tags=[]
contexts=[]
categories=[]
+++

Hello, world!

EOF
}

main() {

  local dates=( $(date "+%Y%m%d %Y-%m-%d") )
  local date_no_dashes="${dates[0]}"
  local date_dashes="${dates[1]}"

  local name="$1"
  if [[ -z "$name" ]]; then
    usage
    exit 1
  fi

  if [[ ! -d "src" ]]; then
    error "Must be run in repo root."
  fi

  local post_dir="src/content/posts/${date_no_dashes}_${name}"
  local post="$post_dir/index.md"
  if [[ -d "$post_dir" ]]; then
    error "Post $post_dir already exists!"
  fi

  mkdir -p "$post_dir"
  maketext "$name" "$date_dashes" > "$post"
  echo "$post"

  code -r "$post" &
}

main "$@"

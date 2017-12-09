#!/bin/sh

feature=$1

if [[ ! -f "$feature.tar.gz" ]]
then
  echo "Missing $feature.tar.gz!"
else
  echo "Importing $feature.tar.gz"
  echo ""
  tar xvf $feature.tar.gz
  echo ""
  echo "$feature imported."
fi
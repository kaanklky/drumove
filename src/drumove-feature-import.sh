#!/bin/sh

feature=$1

echo ""
if [[ ! -f "$feature.tar.gz" ]]
then
  echo "Missing $feature.tar.gz!"
else
  echo "Controlling drush tool..."
  if [[ ! -f "./drush" ]]
  then
    echo "Cannot find drush, I'm downloading it..."
    wget -q https://github.com/drush-ops/drush/releases/download/8.1.15/drush.phar
    chmod +x drush.phar
    mv drush.phar drush
    echo "Downloaded"
  fi
  echo "Importing $feature.tar.gz"
  echo ""
  tar xvf $feature.tar.gz
  echo ""
  echo "$feature imported."
  echo "Enabling $feature..."
  echo ""
  ./drush en $feature -y
  echo ""
  echo "Writing $feature..."
  echo ""
  ./drush fim $feature --force -y
  echo ""
  echo "I think installation completed! Woo hoo..."
fi
echo ""
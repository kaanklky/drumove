#!/bin/sh

feature=$1

echo "Exporting $feature feature..."
drush fe $feature $feature*
tar cf $feature.tar.gz modules/custom/$feature
rm -rf modules/custom/$feature
echo "'$feature' feature archived as $feature.tar.gz"
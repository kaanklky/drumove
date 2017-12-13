#!/bin/sh

feature=$1
timestamp=`date +%s`

echo ""
echo "Exporting $feature feature..."
drush fe $feature $feature* -y
echo "Customizing '$feature' to avoid conflicts in installation"
echo ""
sed -i '1d' modules/custom/$feature/$feature.info.yml
sed -i "1s/^/name: $feature $timestamp\n/" modules/custom/$feature/$feature.info.yml
mv modules/custom/$feature/$feature.features.yml modules/custom/$feature/$feature_$timestamp.features.yml
mv modules/custom/$feature/$feature.info.yml modules/custom/$feature/$feature_$timestamp.info.yml
mv modules/custom/$feature modules/custom/$feature_$timestamp
echo ""
echo "Customization completed"
tar cf $feature_$timestamp.tar.gz modules/custom/$feature_$timestamp
rm -rf modules/custom/$feature_$timestamp
echo "'$feature' feature archived as $feature_$timestamp.tar.gz"
echo ""
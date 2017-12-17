#!/bin/sh

feature=$1
timestamp=`date +%s`

echo ""
echo "Exporting $feature feature..."
drush fe $feature $feature* -y
echo "Customizing '$feature' to avoid conflicts in installation..."
sed -i '1d' modules/custom/$feature/$feature.info.yml
sed -i "1s/^/name: $feature $timestamp\n/" modules/custom/$feature/$feature.info.yml
mv modules/custom/$feature/$feature.features.yml modules/custom/$feature/${feature}_${timestamp}.features.yml
mv modules/custom/$feature/$feature.info.yml modules/custom/$feature/${feature}_${timestamp}.info.yml
mv modules/custom/$feature modules/custom/${feature}_${timestamp}
echo "Customization completed"
tar cf ${feature}_${timestamp}.tar.gz modules/custom/${feature}_${timestamp}
rm -rf modules/custom/${feature}_${timestamp}
echo "'$feature' feature archived as ${feature}_${timestamp}.tar.gz"
echo ""
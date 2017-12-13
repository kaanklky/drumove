#!/bin/sh

NEEDCORE=""
GITFOLDER=""
OVERWRITE=""
GENERATOR=DRUMOVE
DESTINATION="backup.tar.gz"

function askQ () {
  count=1
  first_arg="$2"
  echo ""
  echo "    $1"
  for var in "${@:2}"
  do
    echo "    #$count - $2"
    ((count++))
    shift
  done
  echo ""
}

clear

echo ""
sleep .05
echo ""
sleep .05
echo "     ______     _______               _______    _______               _______   "
sleep .05
echo "    (  __  \   (  ____ )  |\     /|  (       )  (  ___  )  |\     /|  (  ____ \\   "
sleep .05
echo "    | (  \  )  | (    )|  | )   ( |  | () () |  | (   ) |  | )   ( |  | (    \/   "
sleep .05
echo "    | |   ) |  | (____)|  | |   | |  | || || |  | |   | |  | |   | |  | (__   "    
sleep .05
echo "    | |   | |  |     __)  | |   | |  | |(_)| |  | |   | |  ( (   ) )  |  __)   "  
sleep .05
echo "    | |   ) |  | (\ (     | |   | |  | |   | |  | |   | |   \ \_/ /   | (   " 
sleep .05
echo "    | (__/  )  | ) \ \__  | (___) |  | )   ( |  | (___) |    \   /    | (____/\\   "
sleep .05
echo "    (______/   |/   \\__/  (_______)  |/     \\|  (_______)     \\_/     (_______/   "
sleep .05
echo ""
sleep .05
echo ""
sleep .05
echo ""
sleep .05

askQ "You want to do" "System Backup" "System Restore" "Config Backup" "Config Restore" "Feature Export" "Feature Import"
read -p "    #: " answer
if [ "${answer:0:1}" == "1" ]
then 
  # System Backup
  askQ "You need the core?" "Yes" "No"
  read -p "    #: " answer
  if [ "${answer:0:1}" == "2" ]
  then
    # Exclude core
    NEEDCORE="--no-core"
  fi

  # If has .git folder
  if [[ -d ".git" ]]
  then
    askQ "Do you need .git folder?" "Yes" "No"
    read -p "    #: " answer
    if [ "${answer:0:1}" == "2" ]
    then
      GITFOLDER="--tar-options=\"--exclude=.git\""
    fi
  fi

  if [[ -f "backup.tar.gz" ]]
  then
    askQ "There is a backup file already, overwrite?" "Yes" "No"
    read -p "    #: " answer
    if [ "${answer:0:1}" == "1" ]
    then
      OVERWRITE="--overwrite"
    fi
  fi

  drush archive-dump --generator=$GENERATOR --destination=$DESTINATION $NEEDCORE $GITFOLDER $OVERWRITE
  
elif [ "${answer:0:1}" == "2" ]
then
  # System Restore
  if [[ ! -f "backup.tar.gz" ]]
  then
    echo "    Missing backup archive!"
  else
    tar -xvf backup.tar.gz --strip 1
  fi
elif [ "${answer:0:1}" == "3" ]
then
  # Config Backup
  echo "    Creating backup of config files..."
  drush cex --destination=config
  tar cf config.tar.gz config/
  rm -rf config/
  echo "   Config files archived as config.tar.gz"
elif [ "${answer:0:1}" == "4" ]
then
  # Config Restore
  if [[ ! -f "config.tar.gz" ]]
  then
    echo "    Missing config.tar.gz!"
  else
    echo "    Importing config.tar.gz"
    tar xf config.tar.gz
    drush cim --source=config
    rm -rf config/
    echo "    Config files imported."
  fi
elif [ "${answer:0:1}" == "5" ]
then
  # Feature Export
  drush fl --fields=Machine\ name
  askQ "Write machine name to export"
  read -p "    #: " answer
  echo "    Exporting $answer feature..."
  drush fe $answer $answer*
  tar cf feature.tar.gz modules/custom/$answer
  rm -rf modules/custom/$answer
  echo "    '$answer' feature archived as feature.tar.gz"
elif [ "${answer:0:1}" == "6" ]
then
  # Feature Import
  if [[ ! -f "feature.tar.gz" ]]
  then
    echo "    Missing feature.tar.gz!"
  else
    echo "    Importing feature.tar.gz"
    echo ""
    tar xvf feature.tar.gz
    echo ""
    echo "    Feature imported."
  fi
else
  echo "    Exit"
fi

echo ""
echo ""
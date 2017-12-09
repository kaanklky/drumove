# drumove
Little helper to backup/restore drupal as full or without core system, export/import features from drupal.
<br><br>
## Usage
Scripts are based on [Drush](https://github.com/drush-ops/drush) 8.x, [Features](https://www.drupal.org/project/features) and tested on Drupal 8.x.
Place script which you want to use to root path of Drupal installation.
<br><br>
### src/drumove.sh
Full script, just run on terminal. You can;
- Create full backup
- Create backup without Drupal core
- Restore backup
- Backup all configs
- Restore all configs
- Feature export
- Feature import

### src/drumove-feature-export.sh
Minimalized to just export a feature, run;
`./drumove-feature-export.sh <feature-name>`

It will create _feature-name.tar.gz_ file on same path as script.
<br><br>
### src/drumove-feature-import.sh
Minimalized to just import a feature, run;
`./drumove-feature-import.sh <feature-name>`

It will extract _feature-name.tar.gz_ to _modules_ directory of Drupal.
<br><br>
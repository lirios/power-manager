#!/bin/bash

LUPDATE=${LUPDATE-lupdate}

###
# Update source translation files
###

daemondir=src/daemon
mkdir -p $daemondir/translations
$LUPDATE $daemondir -ts -no-obsolete $daemondir/translations/liri-power-manager.ts

indicatordir=src/indicators/power
mkdir -p $indicatordir/translations
$LUPDATE $indicatordir/contents -ts -no-obsolete $indicatordir/translations/power.ts

settingsdir=src/settings/power
mkdir -p $settingsdir/translations
$LUPDATE $settingsdir/contents -ts -no-obsolete $settingsdir/translations/power.ts

tx push --source --no-interactive

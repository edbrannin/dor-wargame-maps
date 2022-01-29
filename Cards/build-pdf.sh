#!/bin/bash

# exit when any command fails
set -e

BASE_DIR=${1:-rc3}
OUT_FILE_BASENAME="all-cards-superiorpod-${BASE_DIR%/}"
OUT_FILE=$BASE_DIR/${OUT_FILE_BASENAME}.pdf
SCALED_OUT_FILE=$BASE_DIR/${OUT_FILE_BASENAME}-scaled.pdf

echo Base dir is $BASE_DIR

#cowsay -n <<EOF

cat <<EOF | xargs pdfunite
$BASE_DIR/deck-layers_Wild.pdf
$BASE_DIR/deck-layers_Wild.pdf
$BASE_DIR/deck-layers_Monroe\\ East.pdf
$BASE_DIR/deck-layers_Monroe\\ Central.pdf
$BASE_DIR/deck-layers_Monroe\\ West.pdf
$BASE_DIR/deck-layers_St\\ Rose\\ of\\ Lima.pdf
$BASE_DIR/deck-layers_St\\ Paul\\ of\\ the\\ Cross.pdf
$BASE_DIR/deck-layers_St\\ Mary\\ Honeyoye.pdf
$BASE_DIR/deck-layers_Holy\\ Family\\ Wayland.pdf
$BASE_DIR/deck-layers_St\\ John\\ Vianney\\ Hammondsport\\ Bath.pdf
$BASE_DIR/deck-layers_St\\ Agnes\\ Avon.pdf
$BASE_DIR/deck-layers_St\\ Luke\\ the\\ Evengelist.pdf
$BASE_DIR/deck-layers_Our\\ Lady\\ of\\ the\\ Valley\\ Hornell.pdf
$BASE_DIR/deck-layers_St\\ Matthew\\ Livonia.pdf
$BASE_DIR/deck-layers_St\\ Peter.pdf
$BASE_DIR/deck-layers_St\\ Michaels\\ Newark.pdf
$BASE_DIR/deck-layers_St\\ Patrick\\ Victor.pdf
$BASE_DIR/deck-layers_St\\ Katherine\\ Drexel.pdf
$BASE_DIR/deck-layers_St\\ Maximilian\\ Kolbe.pdf
$BASE_DIR/deck-layers_St.\\ Francis\\ and\\ St.\\ Claire.pdf
$BASE_DIR/deck-layers_St.\\ Joseph\\ The\\ Worker.pdf
$BASE_DIR/deck-layers_Our\\ Lady\\ of\\ the\\ Lakes\\ Penn\\ Yan.pdf
$BASE_DIR/deck-layers_St.\\ Benedict.pdf
$BASE_DIR/deck-layers_Blessed\\ Trinity,\\ Wolcott.pdf
$BASE_DIR/deck-layers_Our\\ Lady\\ of\\ Peace\\ Geneva.pdf
$BASE_DIR/deck-layers_Blessed\\ Trinity\\ Tioga\\ County.pdf
$BASE_DIR/deck-layers_Ss\\ Isidore\\ and\\ Maria\\ Torribia.pdf
$BASE_DIR/deck-layers_All\\ Saints\\ Corning.pdf
$BASE_DIR/deck-layers_Blessed\\ Sacrament\\ Elmira.pdf
$BASE_DIR/deck-layers_Christ\\ the\\ Redeemer\\ Elmira.pdf
$BASE_DIR/deck-layers_St.\\ Mary\\ of\\ the\\ Lake.pdf
$BASE_DIR/deck-layers_St.\\ Mary\\ Our\\ Mother\\ Horseheads.pdf
$BASE_DIR/deck-layers_St\\ Patrick\\ Tioga\\ County.pdf
$BASE_DIR/deck-layers_St\\ Mary\\ Elmira.pdf
$BASE_DIR/deck-layers_Our\\ Lady\\ of\\ Snows.pdf
$BASE_DIR/deck-layers_Holy\\ Cross\\ Freeville.pdf
$BASE_DIR/deck-layers_Immaculate\\ Conception\\ Ithaca.pdf
$BASE_DIR/deck-layers_Auburn.pdf
$BASE_DIR/deck-layers_Good\\ Shepherd\\ Aurora.pdf
$BASE_DIR/deck-layers_All\\ Saints\\ Lansing.pdf
$BASE_DIR/deck-layers_St\\ Anthony\\ Groton.pdf
$BASE_DIR/deck-layers_Sacred\\ Heart\\ St\\ Anne.pdf
$BASE_DIR/deck-layers_Mary\\ Mother\\ of\\ Mercy.pdf
$BASE_DIR/deck-layers_St\\ Catherine\\ of\\ Siena.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Blank.pdf
$BASE_DIR/deck-layers_Card\\ Back\\ -\\ Knotted.pdf
$OUT_FILE
EOF


cowsay Wrote $OUT_FILE
ls -l $OUT_FILE

pdfscale -r 'custom mm 67 92' $OUT_FILE $SCALED_OUT_FILE

ls -l $SCALED_OUT_FILE

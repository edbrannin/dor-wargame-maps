#!/bin/bash

BASE_DIR=${1:-rc2}
OUT_FILE=$BASE_DIR/all-cards-superiorpod.pdf
SCALED_OUT_FILE=$BASE_DIR/all-cards-superiorpod-scaled.pdf

echo Base dir is $BASE_DIR

#cowsay -n <<EOF

cat <<EOF | xargs pdfunite
$BASE_DIR/deck-layers_003_Wild.pdf
$BASE_DIR/deck-layers_003_Wild.pdf
$BASE_DIR/deck-layers_004_Monroe\\ East.pdf
$BASE_DIR/deck-layers_005_Monroe\\ Central.pdf
$BASE_DIR/deck-layers_006_Monroe\\ West.pdf
$BASE_DIR/deck-layers_007_St\\ Rose\\ of\\ Lima.pdf
$BASE_DIR/deck-layers_008_St\\ Paul\\ of\\ the\\ Cross.pdf
$BASE_DIR/deck-layers_009_St\\ Mary\\ Honeyoye.pdf
$BASE_DIR/deck-layers_010_Holy\\ Family\\ Wayland.pdf
$BASE_DIR/deck-layers_011_St\\ John\\ Vianney\\ Hammondsport\\ Bath.pdf
$BASE_DIR/deck-layers_012_St\\ Agnes\\ Avon.pdf
$BASE_DIR/deck-layers_013_St\\ Luke\\ the\\ Evengelist.pdf
$BASE_DIR/deck-layers_014_Our\\ Lady\\ of\\ the\\ Valley\\ Hornell.pdf
$BASE_DIR/deck-layers_015_St\\ Matthew\\ Livonia.pdf
$BASE_DIR/deck-layers_016_St\\ Peter.pdf
$BASE_DIR/deck-layers_017_St\\ Michaels\\ Newark.pdf
$BASE_DIR/deck-layers_018_St\\ Patrick\\ Victor.pdf
$BASE_DIR/deck-layers_019_St\\ Katherine\\ Drexel.pdf
$BASE_DIR/deck-layers_020_St\\ Maximilian\\ Kolbe.pdf
$BASE_DIR/deck-layers_021_St.\\ Francis\\ and\\ St.\\ Claire.pdf
$BASE_DIR/deck-layers_022_St.\\ Joseph\\ The\\ Worker.pdf
$BASE_DIR/deck-layers_023_Our\\ Lady\\ of\\ the\\ Lakes\\ Penn\\ Yan.pdf
$BASE_DIR/deck-layers_024_St.\\ Benedict.pdf
$BASE_DIR/deck-layers_025_Blessed\\ Trinity,\\ Wolcott.pdf
$BASE_DIR/deck-layers_026_Our\\ Lady\\ of\\ Peace\\ Geneva.pdf
$BASE_DIR/deck-layers_027_Blessed\\ Trinity\\ Tioga\\ County.pdf
$BASE_DIR/deck-layers_028_Ss\\ Isidore\\ and\\ Maria\\ Torribia.pdf
$BASE_DIR/deck-layers_029_All\\ Saints\\ Corning.pdf
$BASE_DIR/deck-layers_030_Blessed\\ Sacrament\\ Elmira.pdf
$BASE_DIR/deck-layers_031_Christ\\ the\\ Redeemer\\ Elmira.pdf
$BASE_DIR/deck-layers_032_St.\\ Mary\\ of\\ the\\ Lake.pdf
$BASE_DIR/deck-layers_033_St.\\ Mary\\ Our\\ Mother\\ Horseheads.pdf
$BASE_DIR/deck-layers_034_St\\ Patrick\\ Tioga\\ County.pdf
$BASE_DIR/deck-layers_035_St\\ Mary\\ Elmira.pdf
$BASE_DIR/deck-layers_036_Holy\\ Cross\\ Freeville.pdf
$BASE_DIR/deck-layers_037_Immaculate\\ Conception\\ Ithaca.pdf
$BASE_DIR/deck-layers_038_Auburn.pdf
$BASE_DIR/deck-layers_039_Good\\ Shepherd\\ Aurora.pdf
$BASE_DIR/deck-layers_040_All\\ Saints\\ Lansing.pdf
$BASE_DIR/deck-layers_041_St\\ Anthony\\ Groton.pdf
$BASE_DIR/deck-layers_042_Sacred\\ Heart\\ St\\ Anne.pdf
$BASE_DIR/deck-layers_043_Mary\\ Mother\\ of\\ Mercy.pdf
$BASE_DIR/deck-layers_044_St\\ Catherine\\ of\\ Siena.pdf
$BASE_DIR/deck-layers_045_Our\\ Lady\\ of\\ Snows.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_046_Blank.pdf
$BASE_DIR/deck-layers_002_Card\\ Back.pdf
$OUT_FILE
EOF


echo Wrote $OUT_FILE
ls -l $OUT_FILE

pdfscale -r 'custom mm 67 92' $OUT_FILE $SCALED_OUT_FILE

ls -l $SCALED_OUT_FILE

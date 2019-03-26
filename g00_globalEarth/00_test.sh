#!/bin/sh

outfile="test.ps"
range="-R-15/345/-75/75"
proj="-JM10c" 
frames="-Bxa45 -Bya20"
inputTopoB="./99_data/ETOPO1_Ice_g_gmt4.grd"
inputTopoL="./99_data/ETOPO1_Ice_g_gmt4.grd"
eqfile="./99_data/earth1950-2019gt6p5.csv"
bathcpt="sea.cpt"
landcpt="land.cpt"
depthcpt="depth.cpt"

#gmt pscoast $proj $range -W1p -Dc -N1/0.5p -K > $output
#gmt psbasemap $proj $range $frames -O >> $output

gmt set PS_MEDIA 21cx30c MAP_GRID_CROSS_SIZE_PRIMARY 0.2c \
        PS_SCALE_X 1.5 PS_SCALE_Y 1.5 
scale="-Lf20/33.5/36:24/100+l+jr" 

gmt psbasemap $proj $range $frames -K --FONT_ANNOT_PRIMARY=10p --FONT_LABEL=10p > $outfile
gmt makecpt -Crelief.cpt -T-8000/8000/150 -Z > $bathcpt
gmt grdimage $inputTopoB $range $proj -C$bathcpt -K -O >> $outfile
#gmt pscoast $proj -P $range -Df -Gc -K -O >> $outfile

gmt makecpt -Chot.cpt -T-100/100/8 -G0/1 > $depthcpt
gmt psxy $eqfile $proj $range -Scp -W0.01p -C$depthcpt -O -K >> $outfile
	# land
#gmt	makecpt -Crelief.cpt -T-3000/1800/50 -Z > $landcpt
#gmt	grdimage $inputTopoL $range $proj -C$landcpt  -K -O >> $outfile
#gmt pscoast -R -J -O -K -Q >> $outfile
	#------- coastline -------------------------------------------
#gmt psbasemap -R -J -O -K $frames --FONT_ANNOT_PRIMARY=20p --FONT_LABEL=20p >> $outfile
#gmt pscoast -J -R -Df -W0.25p,black -K -O -U$logo_pos >> $outfile


#!/bin/sh

# Installation of software using anaconda
#conda install -c bioconda ucsc-bedgraphtobigwig
#conda install -c bioconda deeptools

# usage:
#  ./draw_figure.sh

# Convert a bedGraph file to bigWig format
for i in `less ./file/sample_list.txt`
do
bedGraphToBigWig ./data/${i}.bed ./file/mm9.chrom.sizes ./data/${i}.bw
done

# make figure using deeptools
computeMatrix scale-regions -S ./data/ESC.bw ./data/NSC_E11.bw ./data/NSC_E14.bw ./data/NSC_E18.bw ./data/Neuron.bw ./data/Astrocyte.bw ./data/Oligodendrocyte.bw -R ./file/mm9.refSeq_Genes_sorted.bed -bs 250 -m 10000 -b 5000 -a 5000 -out ./data/matrix_methyation.tab.gz
plotHeatmap -m ./data/matrix_methyation.tab.gz -out figure_1b.pdf --colorMap YlGnBu --plotFileFormat "pdf" --plotTitle 'methylation levels' --missingDataColor "White" --yMin 0 --yMax 100 --zMin 0 --zMax 100 --heatmapHeight 15


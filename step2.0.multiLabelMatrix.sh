Rscript scripts/demo.GOtermAsLabels.R
perl scripts/piRNAGeneMatrixForECOC.pl \
	data/gProfiler.piRNA_hc.ovaryGene.txt \
	data/dm.piRNA.nick.hc.2019.txt \
	data/7227.protein.info.v11.0.txt \
	data/gProfiler.piRNA_hc.ovaryGene.negCtrl.txt \
	data/fly.goTermOvary.piRNApathway.hc.withNeg.txt \
	data/fly.goTermOvary.piRNApathway.pseudoTsmatrix.hc.txt

ecoc tune --n nets/dm_db_net.ovary.1.txt,nets/dm_exp_net.ovary.1.txt,nets/dm_fus_net.ovary.1.txt,nets/dm_nej_net.ovary.1.txt,nets/dm_pp_net.ovary.1.txt,nets/pcc.cellByGermGene.ovary.1.txt \
		  --res result \
		  --trY data/fly.goTermOvary.piRNApathway.hc.withNeg.txt \
		  --tsY data/fly.goTermOvary.piRNApathway.pseudoTsmatrix.hc.txt \
		  --t 8 --nFold 5 --k 10 --isFirstLabel --isCali --v 

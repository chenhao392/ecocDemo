ecoc tune --n nets/dm_db_net.ovary.1.txt,nets/dm_exp_net.ovary.1.txt,nets/dm_fus_net.ovary.1.txt,nets/dm_nej_net.ovary.1.txt,nets/dm_pp_net.ovary.1.txt,nets/pcc.cellByGermGene.ovary.1.txt \
		  --res result \
		  --trY pathMatrix/fly.goTermOvary.piRNApathway.hc.withNeg.txt \
		  --tsY pathMatrix/fly.goTermOvary.piRNApathway.pseudoTsmatrix.hc.txt \
		  --t 55 --nFold 5 --k 10 --isFirstLabel --isCali --v 

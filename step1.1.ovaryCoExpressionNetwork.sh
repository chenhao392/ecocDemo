tail -n +2 data/matrix.cellByGermGene.idMapped.txt >tmp.txt
ecoc pcc --i tmp.txt --t 8 --o data/pcc.cellByGermGene.idMapped.txt
rm -f tmp.txt
perl scripts/matrix2pair.pl \
	data/pcc.cellByGermGene.idMapped.txt \
	0.5 >data/pairs.cellByGermGene.txt

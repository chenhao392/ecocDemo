ecoc pcc --i matrix.cellByGermGene.txt --t 55 --o pcc.cellByGermGene.txt
perl scripts/matrix2pair.pl pcc.cellByGermGene.txt 0.5 >pairs.cellByGermGene.txt

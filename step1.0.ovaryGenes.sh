# download data
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM4363nnn/GSM4363298/suppl/GSM4363298_7053cells_highquality_ovary.loom.gz
gunzip GSM4363298_7053cells_highquality_ovary.loom.gz

# process scRNAseq data 
Rscript scripts/demo.scRNAseqData.R

# mapping gene IDs to stringDb version 11
perl scripts/idMap.pl \
     data/matrix.ovary.txt \
     data/7227.protein.info.v11.0.txt \
     data/dm_id_mapper_all_mar_2017.txt \
     14,18 >data/matrix.ovary.idMapped.txt 2>/dev/null

perl scripts/idMap.pl \
     data/matrix.cellByGermGene.txt \
     data/7227.protein.info.v11.0.txt \
     data/dm_id_mapper_all_mar_2017.txt \
     14,18 >data/matrix.cellByGermGene.idMapped.txt 2>/dev/null

# genes expressed in germline cluster 1
cut -f1,2 data/matrix.cellByGermGene.idMapped.txt | perl -lane 'print if $F[1] >0' >data/ovary.germlineClust1.gene.txt

# Load loomR and gplots libraries
library(loomR)

# link the loom object
# the loom object is avaialble from NCBI with ID: GSM4363298
data <- connect(filename = "GSM4363298_7053cells_highquality_ovary.loom", mode = "r+")

#load the gene by cluster matrix from the loom object
all.clusterName<-data[["col_attrs/ClusterName"]][]
all.geneName<-data[["row_attrs/Gene"]][]
data.matrix<-data$matrix[,]
rownames(data.matrix)<-as.list(all.clusterName)
colnames(data.matrix)<-as.list(all.geneName)

#subset matrix for genes expressed in germline line cluster 1
data.matrix.germline<-subset(data.matrix,rownames(data.matrix) == "1. Germline Cluster 1" )
data.matrix.germline<-t(data.matrix.germline)
data.matrix.germline<-subset(data.matrix.germline,rowSums(data.matrix.germline) >0 )

#ovary
data.ovary.all <- aggregate(data.matrix,by =list(all.clusterName), FUN = mean)
rownames(data.ovary.all)<-data.ovary.all$Group.1
data.ovary.all<-data.ovary.all[,-1]
data.ovary.all<-t(data.ovary.all)
data.matrix.subSet<-subset(data.ovary.all,rownames(data.ovary.all) %in% rownames(data.matrix.germline))
write.table(data.matrix.subSet,"data/matrix.cellByGermGene.txt",row.names = T,sep="\t",quote = F)
write.table(data.ovary.all,"data/matrix.ovary.txt",row.names = T,sep="\t",quote = F)

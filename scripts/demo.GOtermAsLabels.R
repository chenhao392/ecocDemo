library("gprofiler2")
piRNA.hc.list<-c("fs(1)Yb","papi","Hel25E","piwi","aub","zuc","del","cuff","Hen1","tej","krimp","thoc5","thoc7","armi","thoc6","mael","BoYb","Hpr1","spn-E","vret","rhi","shu","tho2","AGO3","vas","CG8920","tud","CG9754","arx","Nbr","nxf2","SoYb","CG12721","Gasz","squ","qin")
data.ovary<-read.table("ovary.germlineClust1.gene.txt",row.names = 1,header = T,sep = "\t",quote="\"")

#go enrichment analysis for piRNA genes in germline Cluster 1 background
test<-gost(piRNA.hc.list,organism = "dmelanogaster",correction_method ="fdr",sources=c("GO:BP","GO:MF","GO:CC"),custom_bg=rownames(data.ovary))
#subset significant GO terms 
data.selected<-subset(test$result,p_value <1e-12 & term_size >20)
goterm.list<-unique(data.selected$term_id)
#retrieve genes annotated with the go terms 
data.out<-gconvert(goterm.list, organism = "dmelanogaster", target = "STRING",
                   numeric_ns = "", mthreshold = Inf, filter_na = TRUE)
#remove genes with the go terms from all ovary expressed genes
data.ovary.other<-subset(data.ovary,!(rownames(data.ovary) %in% data.out$name))
#second go enrichment analysis for the leftover genes in germline Cluster 1 background
test.other<-gost(rownames(data.ovary.other),organism = "dmelanogaster",correction_method ="fdr",sources=c("GO:BP","GO:MF","GO:CC"),custom_bg=rownames(data.ovary))
#subset significant GO terms 
data.selected.other<-subset(test.other$result,p_value <1e-12 & term_size >20)
goterm.list.other<-unique(data.selected.other$term_id)
#retrieve genes annotated with the go terms in second enrichment analysis
data.out2<-gconvert(goterm.list.other, organism = "dmelanogaster", target = "STRING",numeric_ns = "", mthreshold = Inf, filter_na = TRUE)
data.out<-rbind(data.out,data.out2)
data.ovary.other<-subset(data.ovary,!(rownames(data.ovary) %in% data.out$name))
write.table(data.out,file="gProfiler.piRNA_hc.ovaryGene.txt",quote = F,sep="\t")
write.table(data.ovary.other,file="gProfiler.piRNA_hc.ovaryGene.negCtrl.txt",quote = F,sep="\t")

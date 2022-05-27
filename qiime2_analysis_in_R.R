###export qiime2 feature_table.qza into feature-table.biom format, to be imported into R via phlyoseq

#install.packages("installr")
#library("installr")
#updateR()

if(!requireNamespace("BiocManager")){
  install.packages("BiocManager")
}
BiocManager::install("phyloseq")

#source('http://bioconductor.org/biocLite.R')
#biocLite('phyloseq')

#install.packages("phyloseq")
library("phyloseq")
?import
?import_qiime
?import_biom

install.packages("vegan")
library("vegan")

getwd()
setwd("path_to_directory")

#feature_table <- import_biom("feature-table.biom")
feature_table_small <- import_biom(BIOMfilename	= "albo-table-with-taxonomy.biom", 
                                   treefilename	= "albo-tree.nwk", 
                                   refseqfilename = "albo-ref-sequences.FASTA") #,
                                   #parseFunction=parse_taxonomy_greengenes)
feature_table_small
otu_table(feature_table_small)
tax_table(feature_table_small)

TopNOTUs <- names(sort(taxa_sums(feature_table_small), TRUE)[1:1000])
ent1000   <- prune_taxa(TopNOTUs, feature_table_small)
ent1000
plot_tree(ent1000, color = "Rank5")
plot_bar(ent1000, fill="Rank5")
plot_richness(ent1000) #throws error

###get metadata to work
#physeq1 = merge_phyloseq(physeq, sampledata, random_tree) #sampledata <- full metadata.tsv 
#physeq2 = phyloseq(OTU, TAX, sampledata, random_tree)

###needs metadata to work:
#plot_tree(feature_table_small, color="Genus", shape="BODY_SITE", size="abundance")
#plot_bar(feature_table_small, x="author", fill="family")
#plot_richness(myData, x="BODY_SITE", color="Description")
#plot_heatmap(qiimedata, sample.label="SampleType", species.label="Phylum")

###

###notes, to get phyloseq to work with qiime2 biom file; using command line:
#https://forum.qiime2.org/t/is-there-any-way-to-summarize-taxa-plot-by-category/446/2?u=jairideout
#Change the first line of biom-taxonomy.tsv (i.e. the header) to this:
#> #OTUID     taxonomy        confidence

#biom add-metadata -i albo-feature-table.biom -o albo-table-with-taxonomy.biom --observation-metadata-fp albo-metadata-taxonomy.tsv --sc-separated taxonomy

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

feature_table <- import_biom("feature-table.biom")

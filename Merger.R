#This script is to merge the two data files together given a template file that contains all of the unique DFCI and columns to hold the gene and pathogenic status.

#Will need to run through this script twice. Once with the old sample level data set and another time with the new sample level data set.
pathogenic_file <- read.csv(file.choose())

#Make a new template file that holds all of the genes from both data sets.
template_file <- read.csv(file.choose())

#A vector with genes from both data sets.
genes <- c("ABL1", "ASXL1", "ATM", "BCOR", "BCORL1", "BRAF", "BRCC3", "CALR", "CBL", "CBLB", 
           "CD79B", "CDKN2A", "CEBPA", "CREBBP", "CRLF2", "CSF1R", "CSF3R", "CSNK1A1", "CTCF", 
           "CTNNB1", "CUX1", "DDX41", "DNMT3A", "DNMT3B", "EED", "EGFR", "EP300", "ETNK1", "ETV6", 
           "EZH2", "FANCL", "FLT3", "LUC7L2", "GATA1", "GATA2", "GNAS", "GNB1", "IDH1", "IDH2", "IKZF1", 
           "IKZF2", "IKZF3", "JAK1", "JAK2", "JAK3", "KIT", "KRAS", "MPL", "NF1", "NFE2", "NOTCH1", "NOTCH2", 
           "NOTCH3", "NRAS", "NSD2", "PDGFRA", "PDS5B", "PHF6", "PIGA", "PPM1D", "PRPF40B", "PRPF8", "PTEN", 
           "PTPN11", "RAD21", "RIT1", "RUNX1", "SETBP1", "SETD2", "SF1", "SF3A1", "SF3B1", "SH2B3", "SMC1A", 
           "SMC3", "SRSF2", "STAG2", "STAT3", "STAT5B", "TET2", "TLR2", "TP53", "U2AF1", "U2AF2", "WT1", "XPO1", "ZRSR2")

#The following two vectors hold the column headings, which will be important for indexing and putting the right element into its spot. 
pathogenic_column_headers <- colnames(pathogenic_file)
template_column_headers <- colnames(template_file)


for(r in 1:nrow(pathogenic_file)){
  current_dfci = pathogenic_file[r,3]
  for(c in 1:ncol(pathogenic_file)){
    if(is.na(pathogenic_file[r,c])){
      
    }else if(pathogenic_file[r,c]=="PATHOGENIC"){
      
      pathogenic_status = pathogenic_file[r,c]
      allele_value = pathogenic_file[r,c+1]
      gene = pathogenic_column_headers[c+1]
      
      template_col = which(template_column_headers==gene)
      template_row = which(template_file[,3]==current_dfci)
      template_file[template_row,template_col] = allele_value
      template_file[template_row,template_col-1] = pathogenic_status

    }else if(pathogenic_file[r,c]=="VUS"){
      pathogenic_status = pathogenic_file[r,c]
      allele_value = pathogenic_file[r,c+1]
      gene = pathogenic_column_headers[c+1]
      
      template_col = which(template_column_headers==gene)
      template_row = which(template_file[,3]==current_dfci)
      template_file[template_row,template_col] = allele_value
      template_file[template_row,template_col-1] = pathogenic_status
      
    }
  }
}

write.csv(template_file, "Merge Part 2.csv")

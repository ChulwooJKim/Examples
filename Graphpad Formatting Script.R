#This is supposed to take the condensed data from CBC Analyzer.R and format it for Graphpad.
#Need to edit part 1 to get rid of the edges.

#Requires the file with the mice y data from CBC Analyzer.
gene_file <- read.csv(file.choose())

#Make a new template file that holds all of the genes from both data sets.
holder <- matrix(nrow = 100, ncol = 30)

graphpad_order <- c("Empty", "TT2975", "TT2982", "TT2984", "TT2986", "TT3023", "TT3039", "RB5138", "TT2945", "TT2951", "TT2955", "TT2962", "TT2965", "TT2973", "TT2976", "TT2981", "TT3025", "TT3030", "TT2946", "TT2952", "TT2954", "TT2980", "TT2983", "TT2987", "TT3024", "TT3027", "TT3028", "RB5136", "TT2948", "TT2949", "TT2953", "TT2963", "TT2964", "TT2974", "GG2980", "TT3026", "TT3036", "TT3037", "TT2947", "TT3021", "TT3022", "TT3038", "TT2977", "TT2979", "TT2966", "TT2934", "TT2937", "TT2943", "RB6443", "RB6462", "TT2978", "TT2936", "TT2938", "TT2941", "RB6442", "TT3029", "TT2977", "TT2933", "TT2939", "TT2942", "TT3032", "TT3033", "RB6466", "TT3031", "TT3035", "TT2935", "TT2940", "TT2944")
header <-  c("Sample.No.", "WBC.10.3.uL.", "RBC.10.6.uL.", "HCT...", "PLT.10.3.uL.", "RET..10.6.uL.", "RET....","HGB.g.dL.", "MCV.fL.", "NEUT..10.3.uL.", "MONO..10.3.uL.", "MONO....", "LYMPH..10.3.uL.", "LYMPH....", "NEUT....") 


for(r in 1:nrow(gene_file)){
  row = which(graphpad_order == gsub("[^0-9.-TGRB]", "", gene_file[r,1]))
  for(c in 2:ncol(gene_file)){
      holder[row,c] = gene_file[r,c]
  }
}

counter = 1
for(var in graphpad_order){
  holder[counter,1] = var
  counter = counter + 1
}

count = 1
for(parameter in header){
  holder[1,count] = parameter
  count = count + 1
}

write.csv(holder, "CBCs 32 weeks post pIpC.csv")

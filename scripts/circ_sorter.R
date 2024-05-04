library(data.table)

# outputs

# inputs
circ_dir <- snakemake@input[["circ_dir"]]

# params
contrast <- snakemake@params[["conlist"]]
first <- contrast[[2]]
second <- contrast[[3]]
group <- snakemake@params[["linear_model"]]
sample_id <- snakemake@params[["sample_id"]]
sample <- snakemake@params[["name"]]

metadata <- snakemake@params[["omic_meta_data"]]
md <- read.delim(file=metadata, stringsAsFactors = FALSE)
md <- md[order(md[group]),]

#dir.create(paste0("ciri2_output/", contrast[[1]]), showWarnings = FALSE)
for (ctst in contrast) {
	print(ctst)
	print(contrast)
	print(ctst[[1]])
	first_list <- md$sample_id[which(md$group == ctst[[1]])]
	second_list <- md$sample_id[which(md$group == ctst[[2]])]
	namelist <- append(first_list,second_list)
	ifelse(sample %in% namelist, file.copy(from = circ_dir, to = paste0("ciri2_output/",ctst[[1]],"/ciri2_",sample, ".txt")), print(paste0(sample," is not in ", ctst[[1]])))
}
firstlen <- length(first_list)
secondlen <- length(second_list)
lengths <- append(firstlen, secondlen)
#write.table(namelist, file = paste0(circ_dir, first,"vs",second,"/",paste(circ_dir, first,"vs",second),"_namelist.txt"))
#write.table(lengths, file = paste0(circ_dir, first,"vs",second,"/",paste(circ_dir, first,"vs",second),"_namelengths.txt"))

#ifelse(sample %in% namelist, file.copy(from = circ_dir, to = paste0("ciri2_output/",contrast[[1]],"/ciri2_",sample, ".txt")), print(paste0(sample," is not in ", contrast[[1]])))

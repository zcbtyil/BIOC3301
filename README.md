# BIOC3301 
script "basic.sh" contains commands of following: 
(1) joining paired ends of forward and reverse reads "join_paired_ends.py"
(2) spliting the library to allow quality filtering of reads "split_libraries_fastq.py" 
(3) clustering sequences with similarity higher than 97% using  "pick_closed_reference_otus.py" 
(4) performing alpha, beta, taxonomy and significance analysis using "core_diversity_analysis,py"

file "basic_pipeline" includes scripts of following: 
(1) testing chao of all OTUs using script "chao" 
(2) testing shannon diversity of all OTUs using script"shannon"
(3) testing simpson diversity index of all OTUs using script"simpson"
(4) generating 2D PCoA plots using script "2dplot"
(5) testing significance of the dissiliarity visualised by PCoA plots with variation in nitrogen, phosphorus and potassium using anosim_nitrogen/anosim_phosphorus/anosim_potassium respectively 

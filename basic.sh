#!/bin/bash
#SBATCH -t 3:00:00
#SBATCH -n 24

echo "setting temporary directory"
mkdir -p ~/qiime_tmp
export TMPDIR=~/qiime_tmp

echo "loading modules and virtual environment"
module load eb
module load Miniconda2
source deactivate
source activate qiime1

echo "joining paired reads with SeqPrep"
time join_paired_ends.py -m SeqPrep -f ~/2018_02_smb/Read1.fastq.gz -r ~/2018_02_smb/Read2.fastq.gz -b ~/2018_02_smb/Index.fastq.gz -o ./joined

echo "Demulitplexing and quality filtering, Q-score larger 19, reversing barcodes and barcode reference"
time split_libraries_fastq.py -i ./joined/seqprep_assembled.fastq.gz -b ./joined/seqprep_assembled.fastq_barcodes.fastq -m ~/2018_02_smb/map.tsv -q 19 -o ./slout --rev_comp_barcode --rev_comp_mapping_barcodes

echo "Picking OTUs with Silva"
time pick_closed_reference_otus.py -i ./slout/seqs.fna -o ./otus -a -O 24

echo "Summarizing OTU table"
time biom summarize-table -i ./otus/otu_table.biom

echo "Running core diversity analyses, 30k sampling depth, 97% silva reference tree"
time core_diversity_analyses.py --recover_from_failure -o ./cdout -i ./otus/otu_table.biom -m ~/2018_02_smb/map.tsv -t ~/silva/trees/97/97_otus.tre -e 30000 -a -O 24

echo "closing environment"
source deactivate

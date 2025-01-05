# multi-fasta-split
This repository contains a Bash script to split a MultiFasta file into individual fasta files. It also includes a variant that can be run using SLURM for HPC environments. Unlike other options currently available on GitHub, this script is 100% in Bash, making it more portable and more easily integrated within a HPC cluster framework. 

## Features

- Splits a MultiFasta file into individual fasta files in a given directory.
- Enables proper argument handling for reproducibility purposes.
- Provides a SLURM-compatible script for batch processing.

### Local Execution

```bash
./split_fasta.sh -i <input_file> -o <output_dir>
```
### SLURM Execution

```bash
sbatch split_fasta_slurm.sh <input_file> <output_dir>
```
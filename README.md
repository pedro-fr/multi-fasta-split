# multi-fasta-split
This repository contains Bash scripts to split a MultiFasta file into individual fasta files. It will also include a variant that can be run using SLURM for HPC environments.

## Features

- Splits a MultiFasta file into individual fasta files in a given directory.
- Allows custom prefixes for output file names.
- Enables proper argument handling for reproducibility purposes.
- Will provide a SLURM-compatible script for batch processing.

### Local Execution

```bash
./split_fasta.sh -i <input_file> -o <output_dir>
```
### SLURM Execution

```bash
sbatch split_fasta_slurm.sh <input_file> <output_dir>
```
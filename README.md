# multi-fasta-split
This repository contains Bash scripts to split a MultiFasta file into individual fasta files with custom names. It also includes a variant that can be run using SLURM for HPC environments.

## Features

- Splits a MultiFasta file into individual fasta files in a given directory.
- Allows custom prefixes for output file names.
- Enables proper argument handling for reproducibility purposes.
- Provides a SLURM-compatible script for batch processing.

### Local Execution

```bash
./split_fasta.sh -i <input_file> -o <output_dir> -p <prefix>
```
### SLURM Execution

```bash
sbatch split_fasta_slurm.sh <input_file> <output_dir> <prefix>
```
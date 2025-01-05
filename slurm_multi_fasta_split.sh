#!/bin/bash
#SBATCH --job-name=multi_fasta_split
#SBATCH --output=multi_fasta_split_%j.o
#SBATCH --error=multi_fasta_split_%j.e
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

# Define variables
INPUT_FILE=$1
OUTPUT_DIR=$2

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Call the splitting script
./multi_fasta_split.sh -i "${INPUT_FILE}" -o "${OUTPUT_DIR}"
#!/bin/bash

# Usage function to display help for the script
usage() {
    echo "Usage: $0 -i <input_file> -o <output_dir>"
    echo "  -i  Input MultiFasta file"
    echo "  -o  Output directory for individual fasta files"
    exit 1
}

# Parse command line arguments
while getopts ":i:o:" opt; do
    case ${opt} in
        i )
            input_file=$OPTARG
            ;;
        o )
            output_dir=$OPTARG
            ;;
        \? )
            usage
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "${input_file}" ] || [ -z "${output_dir}" ]; then
    usage
fi

# Print input_file and output_dir for debugging
echo "Input file: ${input_file}"
echo "Output directory: ${output_dir}"

# Create output directory if it doesn't exist
mkdir -p "${output_dir}"

# Function to split MultiFasta file
split_fasta() {
    awk -v output_dir="${output_dir}" '
    /^>/ {
        seq_id = substr($0, 2);
        if (index(seq_id, " ")) {
            seq_id = substr(seq_id, 1, index(seq_id, " ") - 1);
        }
        gsub(/[^a-zA-Z0-9_-]/, "_", seq_id);
        file = sprintf("%s/%s.fa", output_dir, seq_id);
        print $0 > file;
        next;
    }
    { print >> file; }
    ' "${input_file}"
}

# Execute split_fasta function
split_fasta

echo "Splitting complete. Output files are in ${output_dir}."
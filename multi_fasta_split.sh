#!/bin/bash

# Usage function to display help for the script
usage() {
    echo "Usage: $0 -i <input_file> -o <output_dir> -p <prefix>"
    echo "  -i  Input MultiFasta file"
    echo "  -o  Output directory for individual fasta files"
    echo "  -p  Prefix for output file names"
    exit 1
}

# Parse command line arguments
while getopts ":i:o:p:" opt; do
    case ${opt} in
        i )
            input_file=$OPTARG
            ;;
        o )
            output_dir=$OPTARG
            ;;
        p )
            prefix=$OPTARG
            ;;
        \? )
            usage
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "${input_file}" ] || [ -z "${output_dir}" ] || [ -z "${prefix}" ]; then
    usage
fi

# Create output directory if it doesn't exist
mkdir -p "${output_dir}"

# Function to split MultiFasta file
split_fasta() {
    awk -v prefix="${prefix}" -v output_dir="${output_dir}" '
    BEGIN {n_seq=0;}
    /^>/ {
        if(n_seq%1000==0) {
            file=sprintf("%s/%s_chunk_%d.fa", output_dir, prefix, n_seq/1000);
        }
        print >> file;
        n_seq++;
        next;
    }
    { print >> file; }
    ' "${input_file}"
}

# Execute split_fasta function
split_fasta

echo "Splitting complete. Output files are in ${output_dir}."
#!/bin/bash

# Usage function to display help for the script
usage() {
    echo "Usage: $0 -i <input_file> -o <output_dir> [-p <prefix>]"
    echo "  -i  Input MultiFasta file"
    echo "  -o  Output directory for individual fasta files"
    echo "  -p  Prefix for output file names (optional)"
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
if [ -z "${input_file}" ] || [ -z "${output_dir}" ]; then
    usage
fi

# Print input_filet and output_dir for debugging
echo "Input file: ${input_file}"
echo "Output directory: ${output_dir}"

# Create output directory if it doesn't exist
mkdir -p "${output_dir}"

# Functiono to split MultiFasta file
split_fasta() {
    awk -v output_dir="${output_dir}" -v prefix="${prefix}" '
    BEGIN {
        if (prefix != "") {
            prefix = prefix "_";
        }
        print "Output directory:", output_dir;  # Print output_dir for debugging
        print "Prefix:", prefix;  # Print prefix  for debugging
    }
    /^>/ {
        seq_id = substr($0, 2);  # Remove the '>' character
        seq_id = substr(seq_id, 1, index(seq_id, " ") - 1);  # Extract the sequence ID before the first space
        gsub(/[^a-zA-Z0-9_-]/, "_", seq_id);  # Replace invalid characters with '_'
        print "Processing sequence ID:", seq_id;  # Print seq_id for debugging
        if (prefix == "") {
            file = sprintf("%s/%s.fa", output_dir, seq_id);
        } else {
            file = sprintf("%s/%s%s.fa", output_dir, prefix, seq_id);
        }
        print "Output file:", file;  # Print file path for debugging
        print $0 > file;
        close(file);
        next;
    }
    {
        print >> file;
    }
    ' "${input_file}"
}

# Execute split_fasta function
split_fasta

echo "Splitting complete. Output files are in ${output_dir}."
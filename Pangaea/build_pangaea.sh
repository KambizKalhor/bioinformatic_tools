#!/bin/bash
#SBATCH --account=asteen_1130
#SBATCH --partition=main
#SBATCH --mem=32G
#SBATCH --nodes=1
#SBATCH --time=05:00:00


# ==== USAGE ====
# this script is to build Pangaea
# sbatch build_pangaea.sh /path/to/apptainer_cache
# =================

if [ -z "$1" ]; then
    echo "ERROR: You must provide a path for APPTAINER_CACHEDIR"
    echo "Usage: $0 /path/to/cache_dir"
    exit 1
fi

# 1. Set Apptainer cache directory
APPTAINER_CACHEDIR="$1"
export APPTAINER_CACHEDIR

# Make the directory if it doesn't exist
mkdir -p "$APPTAINER_CACHEDIR"

echo "Using Apptainer cache directory: $APPTAINER_CACHEDIR"

# 2. Load Apptainer
module load apptainer

# 3. Download the definition file
curl -O https://raw.githubusercontent.com/KambizKalhor/bioinformatic_tools/master/Pangaea/Pangaea.def

# 4. Build the SIF image
apptainer build Pangaea.sif Pangaea.def

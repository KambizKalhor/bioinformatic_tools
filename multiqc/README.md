# bioinformatic_tools
apptainers used in our lab
# Multiqc
https://github.com/MultiQC/MultiQC

## how to install pangaea:
### 1. Download the installer file
```bash
curl -O https://raw.githubusercontent.com/KambizKalhor/bioinformatic_tools/master/multiqc/build_multiqc.sh
```

### 2. build it, don't forget to set a path for apptainer cache

```bash
sbatch build_multiqc.sh /path/to/apptainer_cache
```
## How to use multiqc
### run as shell
```bash
apptainer shell --no-home Multiqc.sif
```
we use --no-home in order to unbind home directory from the container

### run as script

```bash
path_to_sif_file=/project2/asteen_1130/kami_main_directory/tempelate_apptainers/Pangaea.sif
path_run_pangaea_file=/opt/Pangaea/src/run_pangaea
path_to_R1=/opt/Pangaea/example/linked_reads_example/atcc_short_R1.fastq
path_to_R2=/opt/Pangaea/example/linked_reads_example/atcc_short_R2.fastq
output_path=/project2/asteen_1130/kami_main_directory/tempelate_apptainers/output/
apptainer exec --no-home $path_to_sif_file $path_run_pangaea_file \
  -s 10x \
  -r  $path_to_R1 \
  -R $path_to_R2 \
  -o $output_path
```

---


## Running Pangaea
The `run_pangaea` executable is located in the src directory.
```
# first define paths
path_to_sif_file=/project2/asteen_1130/kami_main_directory/tempelate_apptainers/Pangaea.sif
path_run_pangaea_file=/opt/Pangaea/src/run_pangaea

Usage: apptainer exec $path_to_sif_file $path_run_pangaea_file \ [OPTIONS]
Required arguments:
  -s, --short_type <string>       Short reads type: short, stlfr, tellseq, 10x
                                    If 'short', hybrid assembly is performed and -l, -H, and -p are required.
                                    If 'stlfr', 'tellseq', or '10x', linked assembly is performed and -l, -H, and -p must NOT be set.
                                    For 'stlfr' or 'tellseq', original reads can be directly provided to Pangaea without preprocessing.
                                    For '10x', please ensure barcodes are in the BX:Z tag of the read headers (this can be done using 'longranger basic', followed by deinterleaving the reads).
  -r, --short_R1 <file>           Short reads R1 file
  -R, --short_R2 <file>           Short reads R2 file
  -I, --index <file>              Barcode index for Tell-Seq (required if -s is 'tellseq'; this file is provided with the reads)
  -o, --output_dir <dir>           Output directory (required)
Hybrid assembly (required if -s is 'short'):
  -m, --metaphlan_db <file>       Metaphlan database for species detection (required if -c is 'metaphlan')
  -l, --longreads <file>          Long reads file
  -H, --hybrid_asm <string>       Hybrid assembler: hybridspades, metaplatanus (default: hybridspades)
  -p, --longreads_type <string>   Long reads type: pacbio or nanopore
Optional arguments:
  -c, --cluster <int>             Number of clusters for read binning (default: 30; input metaphlan to detect species number by metaphlan)
  -t, --threads <int>             Number of threads to use (default: 50; applied to all tools that support it)
  -h, --help                      Show this help message and exit
```

The assembled contigs will be in output_dir/final_asm.fa.

## Example of running linked-read assembly
```
cd example/linked_reads_example
apptainer exec $path_to_sif_file $path_run_pangaea_file -s 10x -r atcc_short_R1.fastq.gz -R atcc_short_R2.fastq.gz -o pangaea
```

## Example of running hybrid assembly

```
cd example/hybrid_example
apptainer exec $path_to_sif_file $path_run_pangaea_file -s short -r ../linked_reads_example/atcc_short_R1.fastq.gz -R ../linked_reads_example/atcc_short_R2.fastq.gz -l atcc_longreads_small.fastq.gz -p pacbio -o pangaea
```

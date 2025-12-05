# bioinformatic_tools
apptainers used in our lab
# Pangaea
## how to install pangaea:
### 1. Download the installer file
```bash
curl -O https://raw.githubusercontent.com/KambizKalhor/bioinformatic_tools/master/build_pangaea.sh
```

### 2. build it, don't forget to set a path for apptainer cache
```bash
sbatch build_pangaea.sh /path/to/apptainer_cache
```
## How to use Pangaea
### run as shell
```bash
apptainer shell Pangaea.sif
```

### run as script
```bash
path_to_sif_file=/project2/asteen_1130/kami_main_directory/tempelate_apptainers/Pangaea.sif
path_run_pangaea_file=/opt/Pangaea/src/run_pangaea
path_to_R1=/opt/Pangaea/example/linked_reads_example/atcc_short_R1.fastq
path_to_R2=/opt/Pangaea/example/linked_reads_example/atcc_short_R2.fastq
output_path=/project2/asteen_1130/kami_main_directory/tempelate_apptainers/output/

apptainer exec $path_to_sif_file $path_run_pangaea_file \
  -s 10x \
  -r  $path_to_R1 \
  -R $path_to_R2 \
  -o $output_path
```

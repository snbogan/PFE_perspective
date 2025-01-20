#!/bin/bash
#SBATCH --account=pi-jkoc
#SBATCH --partition=lab-colibri
#SBATCH --qos=pi-jkoc
#SBATCH --job-name=argweaver_sim1
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=snbogan@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --output=argweaver_sim1.out
#SBATCH --error=argweaver_sim1.err
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=68GB

# Load dependencies
module load miniconda3
conda activate argweaver

# Move directories
cd /hb/home/snbogan/pfe

# Align simulated sequences
mafft --thread 8 simulated_population.fasta > simulated_population_mafft.fasta

# Run argweaver on aligned samples
arg-sample -f simulated_population_mafft.fasta \
 -o /hb/home/snbogan/pfe/argweaver_sim1 \
 -N 10000 -m 2.5e-8 -r 1.5e-8 \
 --ntimes 20 --maxtime 100e3 -c 1 -n 100


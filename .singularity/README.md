# Singularity container

- For all practical purposes, it is required to build a Singularity Image File (SIF) tailored for your experiment.
- This can only be done on local machines, not on the HPC Tetralith.
- Note, on Tetralith, Singularity is only available on compute nodes. More information on the [official NSC website [2021-06-16]](https://www.nsc.liu.se/support/singularity/).

## Build

Build with `build PROJECT CASE`, returns `PROJECT-CASE.sif`

```bash
# e.g.
$ build Theoretical Theoretical
```

returns `Theoretical-Theoretical.sif`.

## Copy to HPC

```bash
# e.g.
$ rsync -auzP Theoretical-Theoretical.sif user@tetralith.nsc.liu.se:/.../experiment/.
```

## Run

Example for the result of `build Theoretical Theoretical`

```bash
# note: input dir is not required here, however, it is usually
$ inputdir=$HOME/data/input
$ outputdir=$HOME/data/output
# set bind mount points for input data and Tracmass output
# and run the Singularity Image File (SIF)
$ SINGULARITY_BIND="${inputdir}:/mnt/input:ro,${outputdir}:/mnt/output:rw" singularity run Theoretical-Theoretical.sif
```

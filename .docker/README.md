# Docker contianer

## Build

Test case Theoretical-Theoretical

```bash
export PROJECT=Theoretical
export CASE=Theoretical
# run from Tracmass repository root
docker build --rm \
    --build-arg PROJECT=$PROJECT\
    --build-arg CASE=$CASE\
    --tag tracmass:$PROJECT$CASE \
    --file .docker/Dockerfile .
# optional, save the docker file
docker save -o .docker/tracmass$PROJECT$CASE.tar tracmass:$PROJECT$CASE
```

If not running the test case, first set `NETCDFLIBS` and `ARCH` in `Makefile`.

## Run

```bash
# example
PROJECT=Theoretical
CASE=Theoretical
inputdir=$HOME/data/input
outputdir=$HOME/data/output
mkdir -p $outputdir

docker run --rm \
    --mount type=bind,source=${inputdir},target=/input/,readonly \
    --mount type=bind,source=${outputdir},target=/output/ \
    tracmass:$PROJECT$CASE
```

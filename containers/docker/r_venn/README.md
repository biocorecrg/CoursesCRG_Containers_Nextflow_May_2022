# R-based docker

Good resource of base images: https://hub.docker.com/r/rocker

```bash
docker build -t venn_diagram -f Dockerfile .

mkdir -p $HOME/tmp/output

docker run -v $HOME/tmp/output:/output -v $(pwd)/input_files:/input venn_diagram Rscript do_venn.R /input/venn1.txt /input/venn2.txt
```

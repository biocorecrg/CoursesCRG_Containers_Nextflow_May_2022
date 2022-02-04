#Dummy FASTQC Web service

Place B7_input_s_chr19.fastq.gz file from available datasets in ```$HOME/myscratch```

```bash
docker build -t fastqcwww -f Dockerfile ../../scripts/fastqc

mdkir -p $HOME/myscratch

docker run -d -v $HOME/myscratch:/scratch -p 8083:8083 --name myfastqc fastqcwww
```

Example query from the browser:

http://127.0.0.1:8083/?file=B7_input_s_chr19.fastq

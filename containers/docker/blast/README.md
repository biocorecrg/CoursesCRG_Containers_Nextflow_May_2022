# Docker

```bash
docker build -t blast-debian -f Dockerfile.apt .

docker build -t blast-debian -f Dockerfile.simple .

docker build -t blast-debian-stretch -f Dockerfile.stretch .

docker build -t blast-debian:stretch -f Dockerfile.stretch .

docker build -t blast-debian:stretch -f Dockerfile.volume.stretch .

docker build -t blast-debian:custom -f Dockerfile.custom.stretch .

docker build -t blast-debian:custom-2.10.1 -f Dockerfile.custom.stretch --build-arg BLAST_VERSION=2.10.1 .

docker build -t blast-centos:custom -f Dockerfile.custom.centos7 .

docker build -t blast-conda -f Dockerfile.conda .

docker build -t blast-conda:environment -f Dockerfile.conda.environment .
```

## Alignment of sequences

Let's download sequences in a directory, e. g., ```$HOME/db```

```bash
cd $HOME/db

curl https://www.uniprot.org/uniprot/O75976.fasta -o O75976.fasta

curl https://www.uniprot.org/uniprot/Q90240.fasta -o Q90240.fasta

docker run -v /home/user/db:/blastdb blast-debian:custom blastp -query /blastdb/O75976.fasta -subject /blastdb/Q90240.fasta

docker run -v /home/user/db:/blastdb blast-debian:custom blastp -query /blastdb/O75976.fasta -subject /blastdb/Q90240.fasta > out.blast

docker run -v /home/user/db:/blastdb blast-debian:custom blastp -query /blastdb/O75976.fasta -subject /blastdb/Q90240.fasta -out /blastdb/output.blast
```

## Retrieving a sequence from a formated FASTA file

Let's download Swissprot

```bash
cd $HOME/db

curl http://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/swissprot.gz -o swissprot.gz

gunzip swissprot.gz
```

Let's format the FASTA file

```bash
cd $HOME/db
docker run -v /home/user/db:/blastdb  blast-debian:custom makeblastdb -dbtype prot -parse_seqids -in /blastdb/swissprot
```

We can retrive a FASTA sequence by ID

```bash
docker run -v /home/user/db:/blastdb  blast-debian:custom blastdbcmd -dbtype prot -db swissprot -entry O75976
```

# Docker

Keep a BLAST formatted DB in ```$HOME/db```

```bash
docker build -t blastwww -f Dockerfile ../../scripts/blast

docker run -d -v $HOME/db:/blastdb -p 8089:8081 --name myblast blastwww
```

Example query from the browser:

http://127.0.0.1:8089/?id=O75976

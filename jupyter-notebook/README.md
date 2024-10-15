# jupyter-notebook server
if you need a package you can add it to `requirements.txt`

after adding all packages you need, build the Dockerfile 
```bash
docker build -t mynotebookserver .
```

or you can run the server easily by running the `jupyter-compose.yaml` file.
```bash
docker-compose -f jupyter-compose.yaml up -d
```

then you can browse it in your web browser.
 
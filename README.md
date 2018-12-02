# studynote

This is a notes of my IT study.

To see the book on web, go to the [github pages](https://pancongwen.github.io/studynote/).

## For developer
All notes are writed by markdown in `notes/`.

For building it to html, using:
```bash
make build
```
This command builds the gitbook to `docs/`.

There are two ways that publish to browner.
1. Use python module `SimplyHTTPServer`:
    ```bash
    cd docs/
    python -m SimplyHTTPServer 
    ```

2. Use the project `ChineseTeapot/gitbook`:
    ```bash
    wget https://github.com/ChineseTeapot/gitbook/releases/download/0.0.4/gitbook-x86-0.0.4.zip
    unzip gitbook-x86-0.0.4.zip
    cd gitbook/
    make config PORT=8000 SOURCE=$PWD/../notes NAME=note
    make start NAME=note
    ```
    Wait about 3 min, you can see it on web `localhost:8000`
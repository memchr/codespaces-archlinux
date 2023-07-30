docker run -it $(devcontainer build --workspace-folder . | jq  -r ".imageName[0]") bash 
docker stop $(docker ps -a -q) > /dev/null

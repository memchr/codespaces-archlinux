docker run -it $(devcontainer build --config .devcontainer/arch/devcontainer.json --workspace-folder . | jq  -r ".imageName[0]") bash 

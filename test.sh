_test_release_version=0
if [[ $1 == -r ]]; then
	_test_release_version=1
fi

if ((_test_release_version)); then
	docker run -it $(devcontainer build --workspace-folder . | jq  -r ".imageName[0]") bash 
else
	docker run -it $(devcontainer build --config .devcontainer/testing/devcontainer.json --workspace-folder . | jq  -r ".imageName[0]") bash 
fi
docker stop $(docker ps -a -q) > /dev/null

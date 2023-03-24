run: build
	source ./build.sh && run
build: buildLocally
	source ./build.sh && build
buildLocally: clean
	source ./build.sh && buildLocally
buildInDocker:
	source ./build.sh && buildInDocker
push: build
	source ./build.sh && push
clean:
	source ./build.sh && clean
installArgo:
	source ./build.sh && installArgo
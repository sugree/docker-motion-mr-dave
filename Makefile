DOCKER=docker
TAG=motion-mr-dave

NAME=motion-mr-dave
BUILD_OPTS=--rm
RUN_OPTS=-d \
         -e TIMEZONE="Asia/Bangkok" \
         -p 8080:8080 \
         -p 8081:8081 \
         -p 8082:8082 \
         -p 8083:8083 \
         -p 8084:8084 \
         -v $(PWD)/config:/data1/config \
         -v $(PWD)/storage:/data1/storage

default: build

clean:
	$(DOCKER) rm $(NAME)
	$(DOCKER) rmi $(TAG)

build:
	$(DOCKER) build $(BUILD_OPTS) -t $(TAG) .

run:
	$(DOCKER) run $(RUN_OPTS) --name $(NAME) $(TAG)

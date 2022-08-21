CC=gcc
#MEMFLAGS=-fno-objc-arc
CFLAGS=-framework Foundation $(MEMFLAGS)

all: hello

hello: hello.m
	$(CC) $(CFLAGS) hello.m -o hello


.PHONY: clean

clean:
	rm -f hello

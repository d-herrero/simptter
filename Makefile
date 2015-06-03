all:
	@echo "This Makefile is only for install production purposes"

install:
	docker build -t simptter/simptter .

run:
	docker run -itd -p 127.0.0.1:3000:3000 \
		--name simptter-simptter \
		-w /srv \
		-v /home/simptter/simptter:/srv \
		-i simptter/simptter

run-prod:
	docker run -itd -p 127.0.0.1:3003:3000 \
		--name simptter-simptter-prod \
		-w /srv \
		-v /home/simptter/simptter-prod:/srv \
		-i simptter/simptter

clean:
	- docker rm -f simptter-simptter

clean-prod:
	- docker rm -f simptter-simptter-prod

clean-all: clean
	docker rmi simptter/simptter

attach:
	docker logs simptter-simptter
	docker attach simptter-simptter

update:
	git pull
	make clean
	make run

update-prod:
	make clean-prod
	make run-prod
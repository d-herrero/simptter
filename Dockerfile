FROM altenwald/debian-puppet
MAINTAINER Daniel Herrero <daniel.herrero.101@gmail.com>

VOLUME [ "/srv/simptter" ]

WORKDIR /srv/simptter
ADD puppet /srv/simptter/puppet
ADD Gemfile /srv/simptter/Gemfile

RUN [ "puppet", "apply", "/srv/simptter/puppet/manifests/docker.pp", "--modulepath=/srv/simptter/puppet/modules" ]

CMD [ "bash", "/srv/simptter/puppet/docker-run.sh" ]

EXPOSE 3000
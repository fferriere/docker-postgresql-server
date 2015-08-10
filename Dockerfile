FROM fferriere/base

MAINTAINER ferriere.florian@gmail.com

RUN apt-get update && apt-get install -y postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4

ADD files/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD files/initpg.sh /usr/local/bin/initpg.sh

RUN chown postgres:postgres /usr/local/bin/entrypoint.sh && \
  chown postgres:postgres /usr/local/bin/initpg.sh && \
  chmod u+x /usr/local/bin/entrypoint.sh && \
  chmod u+x /usr/local/bin/initpg.sh

# change user
USER postgres

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 5432

CMD ["/usr/local/bin/entrypoint.sh"]

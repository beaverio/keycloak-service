FROM quay.io/keycloak/keycloak:26.3.3

RUN /opt/keycloak/bin/kc.sh build --db=postgres

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start"]
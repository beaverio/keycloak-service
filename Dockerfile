FROM quay.io/keycloak/keycloak:26.3.2

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

COPY --chown=keycloak:keycloak deployments/non-prod.json /opt/keycloak/data/import/non-prod.json
COPY --chown=keycloak:keycloak --chmod=0755 entrypoint.sh /opt/keycloak/entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/entrypoint.sh"]
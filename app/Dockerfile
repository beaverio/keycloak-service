FROM quay.io/keycloak/keycloak:26.3.2

ENV KC_HEALTH_ENABLED=true \
    KC_METRICS_ENABLED=true \
    KC_DB=postgres \
    KC_PROXY=edge \
    KC_HTTP_ENABLED=true

RUN /opt/keycloak/bin/kc.sh build

EXPOSE 8080
FROM quay.io/keycloak/keycloak:26.3.3

# Build Keycloak for production mode with HTTP enabled and PostgreSQL support
# This allows it to run in production mode behind Render's HTTPS proxy
RUN /opt/keycloak/bin/kc.sh build --db=postgres --http-enabled=true

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]

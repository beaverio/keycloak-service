FROM quay.io/keycloak/keycloak:26.3.2

# Accept build argument for environment
ARG ENVIRONMENT=non-prod

# Copy only the environment-specific realm configuration
COPY realm-config/${ENVIRONMENT}-realm.json /opt/keycloak/data/import/

# Build optimizations for production
RUN if [ "$ENVIRONMENT" = "prod" ]; then /opt/keycloak/bin/kc.sh build; fi
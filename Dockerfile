FROM quay.io/keycloak/keycloak:26.3.2

# Accept build argument for environment
ARG ENVIRONMENT=non-production

# Copy only the environment-specific realm configuration
COPY realm-config/${ENVIRONMENT}.json /opt/keycloak/data/import/

# Build optimizations for production
RUN if [ "$ENVIRONMENT" = "production" ]; then /opt/keycloak/bin/kc.sh build; fi
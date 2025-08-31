FROM quay.io/keycloak/keycloak:26.3.3

# Copy any custom configuration files if needed
# COPY conf/ /opt/keycloak/conf/

# Copy custom themes if needed
# COPY themes/ /opt/keycloak/themes/

# Copy custom providers/extensions if needed
# COPY providers/ /opt/keycloak/providers/

# Build the Keycloak image with PostgreSQL database support and HTTP enabled for production behind proxy
RUN /opt/keycloak/bin/kc.sh build --db=postgres

# Set the entrypoint
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]

FROM instrumentisto/coturn

# Install curl to allow fetching the external IP from within the container (optional)
RUN apk add --no-cache curl

# Default creds (override at runtime with -e TURN_PASSWORD=... and -e TURN_USERNAME=...)
ENV TURN_USERNAME=chat
ENV TURN_PASSWORD=12345
ENV REALM=omegle-chat

# Expose UDP ports used by TURN
EXPOSE 3478/udp
EXPOSE 49152-65535/udp

# Use sh -c so environment variables and command substitution are expanded.
# At runtime you can either pass EXTERNAL_IP or let the container try to fetch it.
# Example run (recommended):
# docker run -d \
#   -e EXTERNAL_IP="$(curl -s https://api.ipify.org)" \
#   -e TURN_PASSWORD=yourpass \
#   -p 3478:3478/udp \
#   -p 49152-65535:49152-65535/udp \
#   yourimage
CMD ["sh",  "-c", "turnserver --lt-cred-mech --fingerprint --user=${TURN_USERNAME}:${TURN_PASSWORD} --realm=${REALM} --listening-port=3478 --min-port=49152 --max-port=65535 --no-multicast-peers --no-loopback-peers --log-file=stdout --external-ip=${EXTERNAL_IP:-$(curl -s https://api.ipify.org)}"]

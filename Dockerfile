FROM instrumentisto/coturn

ENV TURN_USERNAME=chat
ENV TURN_PASSWORD=12345
ENV REALM=omegle-chat
ENV EXTERNAL_IP=0.0.0.0

CMD ["turnserver",
"--lt-cred-mech",
"--fingerprint",
"--user=chat:12345",
"--realm=omegle-chat",
"--listening-port=3478",
"--min-port=49152",
"--max-port=65535",
"--no-multicast-peers",
"--no-loopback-peers",
"--log-file=stdout"]

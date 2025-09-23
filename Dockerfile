# renovate: datasource=docker depName=ghcr.io/apollographql/apollo-mcp-server extractVersion=^[^_]+
FROM ghcr.io/apollographql/apollo-mcp-server:v0.8.0

COPY mcp.yaml /mcp.yaml

EXPOSE 5000

CMD ["mcp.yaml"]
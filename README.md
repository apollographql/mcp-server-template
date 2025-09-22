[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/apollo-mcp-server)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=github.com/apollographql/mcp-server-template)

# Apollo MCP Server Template

A starting point for deploying only the Apollo MCP Server. This template provides easy deployment options for **Railway** and **Render**.

> 💡 **Quick Start**: This template uses the Apollo MCP Server container with sensible defaults. You can deploy immediately or customize the configuration for your specific needs.

## Prerequisites

- A [GraphOS account](https://www.apollographql.com/docs/graphos/) (Free and usage-based tiers available)
- Your `APOLLO_KEY` and `APOLLO_GRAPH_REF` from GraphOS Studio

## Deploy Options

### Option 1: Use Railway Template (Recommended)
For the easiest deployment experience, use the official Railway template:
**[Deploy with Railway Template](https://railway.com/deploy/apollo-mcp-server)**

### Option 2: Clone and Deploy
For more control or to use other platforms:

1. **Fork or clone this repository to your own repo**
2. **Set up your environment variables** in your deployment platform:
   - `APOLLO_KEY` - Your Graph API key
   - `APOLLO_GRAPH_REF` - Your graph reference (e.g., `my-graph@production`)
3. **Deploy using one of the options below**:

**Railway**: Use the deploy button above or connect your repo in Railway

**Render**: Use the deploy button above or connect your repo in Render

## What's included

- `Dockerfile`—configured to use the Apollo MCP Server container
- `render.yaml`—Render deployment configuration
- `mcp.yaml`—sample MCP server configuration
- `.apollo/`—JSON schemas for better IDE experience
- `.github/workflows/`—automated dependency updates
- `.vscode/` and `.idea/`—recommended editor settings (install recommended extensions when prompted)
- `renovate.json`—keeps MCP Server version up to date

### MCP Server Features

When enabled, the MCP server provides:
- Schema introspection capabilities for AI assistants
- Structured access to GraphQL operations
- Enhanced development experience with AI tools

## Local Development

**Quick test with Docker:**
```bash
docker build -t apollo-mcp-server .
docker run -it --env APOLLO_KEY=your-key --env APOLLO_GRAPH_REF=your-graph-ref -p 5000:5000 apollo-mcp-server
```

**Using environment file:**
```bash
# Create .env file (don't commit this!)
echo "APOLLO_KEY=your-key-here" > .env
echo "APOLLO_GRAPH_REF=your-graph-ref-here" >> .env

# Run with env file
docker run -it --env-file .env -p 5000:5000 apollo-mcp-server
```

Use `http://localhost:5000/mcp` to connect to your MCP Server.

## Running Locally Without GraphOS

You can run the Apollo MCP Server locally using any GraphQL schema file instead of connecting to GraphOS. This is useful for:
- Local development without internet connectivity
- Testing federation changes before publishing
- Running in air-gapped environments

### Steps to Run with Local Schema

1. **Modify the `schema.graphql` local file** with your API schema

2. **Edit your `mcp.yaml` for local resources**
   ```yaml
   operations:
     source: local
     paths: 
       - tools
   schema:
     source: local
     path: schema.graphql
   ```

3. **Create a modified Dockerfile** for local development:
   ```dockerfile
   FROM ghcr.io/apollographql/apollo-mcp-server:v0.8.0

   COPY mcp.yaml /mcp.yaml
   COPY schema.graphql /schema.graphql
   COPY tools /tools

   EXPOSE 5000
   WORKDIR /

   CMD ["mcp.yaml"]
   ```

4. **Run the MCP server without GraphOS credentials**:
   ```bash
   # Build the container
   docker build -t apollo-mcp-server-local .
   
   # Run without APOLLO_KEY and APOLLO_GRAPH_REF
   docker run -it -p 5000:5000 apollo-mcp-server-local
   ```

### Notes on Local Development

- You must re-build the dockerfile when you add operations to the tools folder (no automatic hot-reloading with Docker)

## ⚠️ Security Configuration

This template includes development-friendly defaults that **are not production-ready**. Review these settings before deploying to production:

### Introspection Tools Enabled
These tools were designed to help developers understand their graph and generate operations tha can be used as tools. We don't recommend running these in production for consumer facing experiences as the dynamic generation capabilities require testing to ensure the schema is easily understandable for LLMs. We recommend using [GraphOS contracts](https://www.apollographql.com/docs/graphos/platform/schema-management#contracts) to filter out fields in your schema that contribute to poorly generated oeprations. 

- **Introspect**: Provides any `type` by name and can have a depth level of what is returned. For large schemas, a depth of 1 should always be used
- **Search**: Allows searching the loaded schema based on a set of search terms.
- **Validate**: Validates a given GraphQL operation against the loaded schema.
- **Execute**: Executes a given GraphQL operation. 

## Recommended Next Steps

Once you have your MCP server deployed, consider these production-ready improvements:

- [ ] **Set up CI/CD** to automatically deploy newer versions
- [ ] **Enable Renovate** on your repo to keep MCP server up to date
- [ ] **Set up deployment previews** for PRs to test changes
- [ ] **Review security settings** in your MCP server configuration:
  - [ ] Set up proper authentication/authorization
- [ ] **Monitor your MCP Server** with GraphOS observability features and OpenTelemetry
- [ ] **Clean up unused deployment files** (e.g., delete `render.yaml` if using Railway)

## Support

For issues with:
- **Apollo MCP Server**: Check the [Apollo MCP Server documentation](https://www.apollographql.com/docs/apollo-mcp-server/)
- **GraphOS**: Visit [GraphOS documentation](https://www.apollographql.com/docs/graphos/)
- **This template**: Open an issue in this repository

## License

This template is available under the MIT License. See [LICENSE](LICENSE) for details.

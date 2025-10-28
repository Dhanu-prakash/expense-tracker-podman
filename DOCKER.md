# Docker Deployment Guide for ExpenseHub

ExpenseHub is a containerized expense tracking application designed to run seamlessly in Docker containers, particularly in Red Hat-based environments.

## 🐳 Quick Start with Docker

### Prerequisites
- Docker Engine 20.10+ or Podman 3.0+
- Node.js 18+ (for local development)

### Building the Container

```bash
# Build the Docker image
docker build -t expensehub:latest .

# Or using Podman (Red Hat/Fedora)
podman build -t expensehub:latest .
```

### Running the Container

```bash
# Run with environment variables
docker run -d \
  -p 8080:8080 \
  --name expensehub \
  -e VITE_SUPABASE_URL=your_supabase_url \
  -e VITE_SUPABASE_PUBLISHABLE_KEY=your_key \
  expensehub:latest

# Or with Podman
podman run -d \
  -p 8080:8080 \
  --name expensehub \
  -e VITE_SUPABASE_URL=your_supabase_url \
  -e VITE_SUPABASE_PUBLISHABLE_KEY=your_key \
  expensehub:latest
```

### Persistent Data with Volume Mounts

```bash
# Create a volume for persistent storage
docker volume create expensehub-data

# Run with volume mount
docker run -d \
  -p 8080:8080 \
  --name expensehub \
  -v expensehub-data:/app/data \
  -e VITE_SUPABASE_URL=your_supabase_url \
  -e VITE_SUPABASE_PUBLISHABLE_KEY=your_key \
  expensehub:latest
```

## 🔧 Configuration

### Environment Variables

The application supports the following environment variables:

- `VITE_SUPABASE_URL` - Your Lovable Cloud/Supabase project URL
- `VITE_SUPABASE_PUBLISHABLE_KEY` - Your publishable API key
- `VITE_SUPABASE_PROJECT_ID` - Project ID (auto-configured)
- `PORT` - Server port (default: 8080)

### Using .env File

Create a `.env` file (not tracked in git):

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=your_publishable_key
VITE_SUPABASE_PROJECT_ID=your_project_id
```

## 🚀 Red Hat OpenShift Deployment

### Deploy to OpenShift

```bash
# Login to your OpenShift cluster
oc login --token=your_token --server=https://api.your-cluster.com

# Create a new project
oc new-project expensehub

# Create app from Dockerfile
oc new-app . --name=expensehub --strategy=docker

# Expose the service
oc expose svc/expensehub

# Get the route
oc get route expensehub
```

### Using OpenShift ConfigMap for Environment Variables

```bash
# Create ConfigMap
oc create configmap expensehub-config \
  --from-literal=VITE_SUPABASE_URL=your_url \
  --from-literal=VITE_SUPABASE_PUBLISHABLE_KEY=your_key

# Reference in deployment
oc set env deployment/expensehub --from=configmap/expensehub-config
```

## 📊 Monitoring & Logging

### View Logs

```bash
# Docker logs
docker logs -f expensehub

# Podman logs
podman logs -f expensehub

# OpenShift logs
oc logs -f deployment/expensehub
```

### Health Checks

The application includes health check endpoints:

- `/` - Application root (always returns 200 if running)
- Health check interval: 30s
- Startup time: 10s

### Adding Health Checks to Docker

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1
```

## 🔄 CI/CD with GitHub Actions

Example GitHub Actions workflow for automated deployment:

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Build Docker image
        run: docker build -t expensehub:${{ github.sha }} .
      
      - name: Push to registry
        run: |
          docker tag expensehub:${{ github.sha }} your-registry/expensehub:latest
          docker push your-registry/expensehub:latest
      
      - name: Deploy to OpenShift
        run: |
          oc login --token=${{ secrets.OPENSHIFT_TOKEN }} --server=${{ secrets.OPENSHIFT_SERVER }}
          oc rollout latest deployment/expensehub
```

## 🛡️ Security Best Practices

1. **Never commit sensitive data** - Use environment variables or secrets
2. **Use non-root user** in containers
3. **Scan images regularly** - Use `docker scan` or `trivy`
4. **Keep base images updated**
5. **Use secrets management** - OpenShift Secrets or HashiCorp Vault

## 📈 Performance Optimization

### Multi-stage Build

The application uses a multi-stage Dockerfile for optimal image size:

```dockerfile
# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
```

### Resource Limits

Set resource limits in OpenShift:

```bash
oc set resources deployment/expensehub \
  --limits=cpu=500m,memory=512Mi \
  --requests=cpu=250m,memory=256Mi
```

## 🐛 Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   # Change the port mapping
   docker run -p 3000:8080 expensehub:latest
   ```

2. **Environment variables not working**
   ```bash
   # Verify env vars are set
   docker exec expensehub env | grep VITE_
   ```

3. **Container crashes on startup**
   ```bash
   # Check logs
   docker logs expensehub
   ```

## 📚 Additional Resources

- [Lovable Cloud Documentation](https://docs.lovable.dev/features/cloud)
- [Docker Documentation](https://docs.docker.com/)
- [OpenShift Documentation](https://docs.openshift.com/)
- [Podman Documentation](https://docs.podman.io/)

## 💡 Development Tips

- Use `docker-compose` for local development with services
- Leverage BuildKit for faster builds
- Use `.dockerignore` to exclude unnecessary files
- Consider using Distroless images for production

---

Built with ❤️ for developers who love beautiful, containerized applications.

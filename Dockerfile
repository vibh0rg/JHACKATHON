FROM node:22-bookworm-slim AS frontend-build
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@10.18.0 --activate
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY patches ./patches
RUN CI=1 pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM python:3.12-slim AS runtime
WORKDIR /app
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=3000
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
    && useradd --create-home --uid 10001 appuser
COPY server_py ./server_py
COPY --from=frontend-build /app/dist/public ./dist/public
USER appuser
EXPOSE 3000
CMD ["sh", "-c", "uvicorn server_py.main:app --host 0.0.0.0 --port ${PORT:-3000}"]

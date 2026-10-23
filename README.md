# Phish-Catch

Phish-Catch is a small tool for checking a message before acting on it. Choose where it came from, paste the text, and the checker returns an estimated scam score, a few reasons for that score, and possible impact on your device, money, accounts, or physical safety. When the result suggests it may help, the page links to relevant India support options.

It only analyzes the text you paste. It does not log in to WhatsApp, Instagram, X, or LinkedIn; open or verify links; scan your device; check your bank account; or submit a report for you. Treat the result as guidance, not a guarantee.

## What it uses

- **Frontend:** React and TypeScript, built with Vite.
- **Backend:** Python and FastAPI.
- **Model service:** the configured Gemini-compatible service, or an OpenAI-compatible API when `OPENAI_API_KEY` is set.

The browser sends the selected app and pasted message to `POST /api/analyze`. FastAPI checks the request, asks the model for a structured assessment, validates the answer, and decides which support actions fit the returned impact levels. The message is analyzed for the request and is not saved as a history entry.

## Run it on your computer

You will need Node.js, pnpm 10.18.0, and Python 3.12 or later. From the project folder, install the dependencies:

```sh
pnpm install --frozen-lockfile
python3 -m pip install -r requirements-dev.txt
```

Configure a model provider in the server environment. The hosted project can use `MANUS_API_URL` with `MANUS_API_KEY`. For a separate setup, use `OPENAI_API_KEY`; `OPENAI_API_BASE` and `OPENAI_MODEL` are optional. Keep these values private and out of Git.

Start the API and website in two terminals, both opened in the project folder:

```sh
# Terminal 1
pnpm dev:api
```

```sh
# Terminal 2
pnpm dev
```

The Python API listens on port 3001. The Vite website runs on port 3000 and forwards its `/api` requests to the Python service.

## Useful commands

```sh
pnpm check       # Check the TypeScript frontend
pnpm test        # Run the TypeScript and Python tests
pnpm build       # Build the website files
pnpm start       # Run the production FastAPI app
```

## Where to look in the code

- `client/src/pages/Home.tsx` contains the message form and results screen.
- `client/src/index.css` contains the page styling.
- `server_py/main.py` defines the HTTP routes, input limits, request throttling, and static-file serving.
- `server_py/analyzer.py` calls the model, checks its response, and maps impact levels to support actions.
- `server_py/test_main.py` and `server_py/test_analyzer.py` cover the Python API and analysis rules.
- `requirements.txt` lists the Python app dependencies; `requirements-dev.txt` adds test dependencies.
- `vite.config.ts` forwards local API calls to FastAPI. `Dockerfile` builds the website with Node and runs it with Python.

For Vercel, `pyproject.toml` points the Python runtime to `server_py.main:app` and tells it to run `pnpm build` first. Set `OPENAI_API_KEY` in Vercel for the model service; the managed `MANUS_API_URL` and `MANUS_API_KEY` values are not automatically available in a separate Vercel project.

The project still contains some TypeScript Express/tRPC starter files under `server/`. The current `pnpm dev`, `pnpm start`, and Docker commands run the Python API instead. The older files are kept for now because the frontend's starter type wiring and tests still refer to parts of them; remove them only as part of a deliberate cleanup and after the checks pass.

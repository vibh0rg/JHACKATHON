# Phish-Catch — implementation plan

## Product and implementation

Phish-Catch lets visitors manually select the source app, paste a message/post/DM and review a scam likelihood score, red flags, potential impact and recommended support. Source choices are SMS, WhatsApp, LinkedIn, Instagram, X/Twitter and Other. This is not a social-platform connection; Phish-Catch does not read accounts, fetch links or scan devices.

The browser UI remains React + TypeScript; browsers execute JavaScript, not Python directly. Replace the active Express analysis backend with FastAPI/Python while preserving same-origin `POST /api/analyze`, its `message` and validated `sourcePlatform` enum (default `other`), 12,000-character text limit, 96 KB JSON limit, eight checks per minute, eight active-analysis cap, 45-second model timeout, validated JSON response, and deterministic India support routing. Use the existing managed Gemini-compatible service when its server-side credentials are available; for independent hosting, also support an owner-supplied OpenAI-compatible API key/model. Keep pasted text untrusted, credentials server-only, and do not save message history. FastAPI also serves `/api/health`, the public platform-config script, and the built React static files in production. During development, Vite proxies API paths to the Python service; run Vite on the existing Preview port and Uvicorn on a separate local port.

### India support routing and verified sources

Use distinct voluntary actions: `112` for high/critical physical danger; `1930` for moderate-or-higher cyber-financial fraud risk; and CERT-In’s toll-free `1800-11-4949` for high/critical device or social-account compromise. The CERT-In official RFC 2350 v1.0 (dated 17 March 2022) identifies a 24/7 incident-response help desk, gives `+91-1800-11-4949`, and says CERT-In serves individuals and home users: `https://www.cert-in.org.in/PDF/RFC2350.pdf`. Its official contacts are `https://www.cert-in.org.in/s2cMainServlet?pageid=CONTACTUS`.

I4C/MHA says the National Cybercrime Reporting Portal supports all types of cybercrime, and identifies 1930 as the cyber-financial-fraud helpline operating in all States/Union Territories: `https://i4c.mha.gov.in/ncrp.aspx`. Online reporting is at `https://cybercrime.gov.in/`. The Government of India directory lists 112 as the integrated ERSS number for police, fire, rescue and health, as well as 1930 for cybercrime: `https://www.india.gov.in/directory/helpline`.

Phone actions require an explicit click. Official portals open separately; the app never dials, files reports or collects government credentials, OTPs or payment details. Persistent 112/1930 links remain available even when AI classification misses a risk. Display an always-visible text-only analysis limitation: no device scan, account check or payment verification occurs. If platform-account risk is high, advise recovery via the selected platform’s official app/site without using links supplied in the suspicious message.

The previously requested user-owned URL remains pending: no exact destination or placement has been supplied, so do not add/change a custom URL and do not use Manus-related names in URLs.

### Project structure

- `client/src/pages/Home.tsx`: accessible source-app choice, message form, risk/impact result, India help actions and account-recovery advice (React/TypeScript frontend).
- `client/src/index.css`: technical console design and responsive source/impact controls.
- `server_py/main.py`: Python FastAPI app, analysis request validation, rate/concurrency limits, health/config routes, and production static-file serving.
- `server_py/analyzer.py`: managed Gemini request, response validation, and deterministic impact-to-support routing.
- `server_py/test_analyzer.py`: Python regression tests for input/source validation, model failures and support routing.
- `requirements.txt`: pinned Python backend/runtime and test dependencies.
- `vite.config.ts`: development API proxy to Uvicorn.
- `Dockerfile`: Node-based React asset build followed by Python/FastAPI runtime.
- `server/_core/index.ts` and `server/phish-analysis.ts`: legacy TypeScript backend source retained for comparison during this migration; production/dev app API is handled by Python.
- `client/public/manus-routes.json`: the existing single-page route.
- `plan.md` and `TODO.md`: scope and progress.

The header gets four keyboard-accessible source tabs: Instagram uses reddish pink, WhatsApp green, X/Twitter black/graphite, and LinkedIn blue. Each tab synchronizes with the existing source selector and applies a restrained matching accent theme to the shared checker; it does not create a separate account connection.

## Visual direction

Retain the user-requested technical monospace security-console look already in the project: graphite/navy surfaces, mint/cyan indicators, coral-red scam warnings, structured panels, concise labels, responsive controls and modest motion that honors reduced-motion preferences. Use the source selector and impact meters as clear operational controls, not decorative dashboard clutter.

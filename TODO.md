# Phish-Catch delivery progress

## Message-checking frontend — complete
- [x] “A single page with a big text box and a ‘Check Message’ button.”
- [x] “Result shows a big Red/Green status and a few bullet points.”
- [x] “The user pastes a suspicious message. The app gives it a ‘Safe’ or ‘Scam’ rating and highlights the red flags (like urgent language or sketchy links).”
- [x] Show clear validation, loading, error, and retry feedback; preserve the entered message if analysis fails.
- [x] Make the interface usable on mobile and accessible by keyboard/screen reader.

## Message-analysis backend — complete
- [x] “A simple API endpoint that takes the text and sends it to the Gemini or OpenAI API with the prompt: ‘Act as a cybersecurity expert. Analyze this message for phishing tactics and return a JSON with a risk score (0-100) and a list of red flags.’” The Python API uses the managed Gemini-compatible endpoint when available, or an OpenAI-compatible API key for independent hosting; credentials stay server-side.
- [x] Return a validated JSON risk score (0-100) and evidence-based red flags; keep provider credentials server-side and do not save submitted messages.

## Interactive and technical design — complete
- [x] “make it look less AI and should have more clicks and buttons to make it more interactive and lively.” Add sample buttons, Clear, an expandable guide, Copy findings and Check another actions.
- [x] “change font to a technical font, gived the front end a tech look.” Use technical monospace typography and a responsive, high-contrast security-console style.

## India cyber-fraud and emergency hand-offs — complete
- [x] “add a cyber secuirty helpline number option as well, if the scam is lethal.” “target india, threaten physical harm or can cause financial danger. The app should direct a button to either hover to the gov site or add gov credentials to take actions if the user chooses to.” Use distinct, user-clicked choices for physical danger and cyber-financial fraud.
- [x] For physical harm, offer `tel:112` and the official India.gov.in emergency directory. For cyber-financial fraud, offer `tel:1930` and the official `https://cybercrime.gov.in/` reporting site. Keep number fallbacks available even if the classifier misses a threat; do not collect credentials/OTPs or submit reports.

## Multi-platform source and threat impact — complete
- [x] “can you make it accessible for linkedin instagram twitter as well?” Support selecting SMS, WhatsApp, LinkedIn, Instagram, X/Twitter or Other before the user pastes the content.
- [x] “like to detect scam, a window to choose which application it came in, then copy paste the content to check the threat/ scam and then the degree of threat level it has on your computer or finance and according to that, cybersecrity support dial recommendation?” Analyze manually pasted text with the selected app as context; show scam likelihood and separate NONE/LOW/MODERATE/HIGH/CRITICAL potential-impact levels for computer, financial, social-account and physical-safety risks. Recommend only the matching Indian official support route: CERT-In `1800-11-4949` for high/critical device/account incidents, `1930` for moderate-or-higher cyber-financial fraud, and `112` for high/critical physical danger. Do not imply that Phish-Catch connects to the user's accounts, scans their computer, verifies transactions, or acts on their behalf.
- [x] Display NONE distinctly from LOW and show the text-only/device/account/payment limitation before submission.

## Header platform sections — complete
- [x] “can you make specific seperate sectins for insta whatsapp twitter and linkedin in the website, on the header, with different color schemes for each. reddish pink, green shade, black shade, blue shade for linkedin” Add separate, keyboard-accessible Instagram, WhatsApp, X/Twitter and LinkedIn tabs in the header; selecting one updates the checker’s source-app selection and applies the requested reddish-pink, green, black/graphite or blue accent theme. Keep the tabs responsive.

## Python backend — complete
- [x] “python” Convert the server-side checker API to Python while retaining the React frontend, since browsers require JavaScript to run this existing user interface. Keep `POST /api/analyze`, the source-platform selection, risk/impact response contract, input protections, Gemini/OpenAI-compatible analysis and India support recommendations working.
- [x] Keep the React app served by Vite in development and FastAPI in production; proxy `/api` to Uvicorn during development, serve `/api/health` and the public platform config, and run the combined app in the container on the configured `PORT`.
- [x] Validate Python backend behavior with the Python test suite; preserve frontend TypeScript checks, UI tests, and the production frontend build.

## User-owned link URL — waiting for exact destination and placement
- [ ] “i want to change the link url to my own.” The user said “dont include manus or any related name to the url” but has not given the exact destination or whether it should replace a sample-message link or be the app’s public/custom domain.

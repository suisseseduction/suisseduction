---
description: Builds and maintains the Suisse Seduction bilingual static website. Use when working on HTML, CSS, JS, project structure, pricing, or copy for suisseduction.ch — the dating/seduction coaching site in Lausanne and Geneva.
mode: all
model: anthropic/claude-sonnet-4-6
---

# AGENT.md — Suisse Seduction Website

This document explains the **concept, business model, and technical architecture** of this repository so AI agents and contributors can work on it effectively.

## What this website is

**Suisse Seduction** (`suisseduction.ch`) is the marketing website for a **private seduction and dating coaching business** based in **Suisse Romande** (French-speaking Switzerland), primarily serving **Lausanne** and **Geneva**.

The site is a **single-page brochure**: it presents the coach, explains the coaching process, lists services and prices, and provides a contact form. It does **not** run a backend, user accounts, payments, or booking logic. All coaching happens offline or via direct contact after a lead submits the form.

**Live URL:** https://www.suisseduction.ch/  
**Custom domain:** configured via `CNAME` → `www.suisseduction.ch`  
**Hosting:** GitHub Pages (static files only)

---

## Business concept

### Value proposition

The coach offers **personalized, in-person and online coaching** to help men improve their dating life. The approach combines:

- A proprietary step-by-step seduction method (delivered as a written guide)
- Practical field training (approaching women in real settings)
- Profile and image optimization for dating apps
- Ongoing feedback on conversations, body language, and messaging

The tone is direct, results-oriented, and motivational. The site sells **transformation through practice**, not passive content.

### Target audience

Men in Switzerland (especially Lausanne and Geneva) who want help with:

- Approaching women in public (**daygame**) or nightlife (**nightgame**)
- Dating apps (**Tinder**, **Bumble**) — profile photos, bios, and conversation strategy
- **Text game** — analyzing and improving message exchanges
- Confidence, style, body language, and overcoming fear of rejection

### Coaching process (site narrative)

The `#about` section describes a five-step journey:

1. **Who am I?** — Coach credentials and track record (12+ years in seduction coaching)
2. **Listening to your needs** — Free, confidential intro call with no commitment
3. **Personalized program** — Tailored plan plus the coach's written method (approach → relationship)
4. **Outings** — Real-world sessions in Lausanne or Geneva (night or day)
5. **Results** — Debrief after each interaction; iterative improvement until goals are met

### Services offered

| Service | Summary |
|--------|---------|
| **Simplified theory** | Exclusive guidebook with the coach's method |
| **Increase your value** | Style, body language, voice, social media presence |
| **Motivation** | Overcoming rejection fear; accountability |
| **Dating apps** | Professional photos + compelling profile copy |
| **Nightgame & Daygame** | In-person outings with live demonstration and feedback |
| **Text game** | Review and optimization of message conversations |

### Pricing (CHF)

Prices are listed in the `#prices` section of `index.html` / `indexen.html`:

| Offering | Price |
|----------|-------|
| Seduction guide (PDF) | Free |
| Intro coaching call (20 min video) | Free |
| Online coaching (video call) | 90 CHF/hour |
| Nightgame (pub/club, Lausanne or Geneva) | 120 CHF/hour or 400 CHF/evening |
| Daygame (Saturday only) | 150 CHF/hour |
| Dating app photo shoot + style coaching | 600 CHF |
| Immersive weekend trip (Fri–Sun, satisfaction guarantee) | 2400 CHF |

The first 20 minutes of a call are free. The contact form is the primary conversion path; leads also see `info@suisseduction.ch` in the footer.

---

## Technical architecture

### Static site on GitHub Pages

This repository is designed to be served **as plain static files**. GitHub Pages reads the repo root (or a configured branch/folder) and serves HTML, CSS, JS, and images directly. There is:

- No server-side rendering
- No database
- No build step required for deployment (built CSS/JS are committed)
- One external dependency for forms: **Formspree** (`https://formspree.io/f/xqaawzdl`)

Deploy by pushing to the GitHub branch configured for Pages. The `CNAME` file ensures the custom domain resolves correctly.

### Theme and stack

The site is based on the **Start Bootstrap "Agency"** one-page theme:

| Layer | Technology |
|-------|------------|
| Markup | HTML5 (`index.html`, `indexen.html`) |
| CSS | Bootstrap 3 + custom `css/agency.css` (compiled from `less/agency.less`) |
| Icons | Font Awesome (vendored in `vendor/font-awesome/`) |
| JS | jQuery, Bootstrap JS, `js/agency.js`, language switcher scripts |
| Fonts | Google Fonts (Montserrat, Kaushan Script, Droid Serif, Roboto Slab) |
| Build (optional) | Gulp (`gulpfile.js`) — LESS compilation, CSS/JS minification, vendor copy |

Vendor libraries live under `vendor/` (Bootstrap, jQuery, Font Awesome) and are committed to the repo so Pages can serve them without `npm install`.

### Bilingual structure

The site supports **French** and **English** via **separate HTML files**, not a runtime i18n framework:

| File | Language | Role |
|------|----------|------|
| `index.html` | French (default) | Primary page; canonical URL points here |
| `indexen.html` | English | Full duplicate with English copy and meta tags |

Language switcher buttons in the navbar redirect between files:

- `js/change_language.js` — used on the French page (FR → `index.html`, EN → `indexen.html`)
- `js/change_language_en.js` — used on the English page

Translatable content uses `lang="fr"` attributes on elements in the French version; the English page has equivalent English text baked into the HTML.

### Page sections (both languages)

Each HTML file is a single scrolling page with anchor navigation:

| Section ID | Purpose |
|------------|---------|
| `#page-top` / header | Hero with logo and tagline |
| `#about` | Timeline — coaching process |
| `#services` | Six service blocks with icons |
| `#prices` | Pricing table |
| `#contact` | Formspree contact form + CTA |

Navbar links use `page-scroll` (from `agency.js`) for smooth scrolling.

### Contact form

The contact form in `#contact` posts to Formspree:

```html
<form action="https://formspree.io/f/xqaawzdl" method="POST">
```

Fields: name, email, phone, message (all required). Client-side validation uses `jqBootstrapValidation.js`. Submissions are handled entirely by Formspree; no server code in this repo processes email.

### SEO and discovery

- `robots.txt` — allows crawlers; points to sitemap
- `sitemap.txt` — lists `index.html` and `indexen.html`
- `BingSiteAuth.xml` — Bing Webmaster verification
- Per-page `<meta description>`, `<meta keywords>`, and `<link rel="canonical">` on the French page

---

## Repository layout

```
suisseduction/
├── index.html              # French homepage (main entry)
├── indexen.html            # English homepage
├── CNAME                   # Custom domain for GitHub Pages
├── robots.txt
├── sitemap.txt
├── BingSiteAuth.xml
├── css/
│   ├── agency.css          # Compiled theme styles
│   └── style.css           # Additional custom styles
├── less/                   # LESS source (edit → compile to css/)
├── scss/                   # SCSS alternative (gulp supports sass task)
├── js/
│   ├── agency.js           # Theme interactions (scroll, navbar)
│   ├── agency.min.js       # Minified (served in production HTML)
│   ├── change_language.js
│   ├── change_language_en.js
│   ├── jqBootstrapValidation.js
│   └── sweetalert.js       # Optional alerts (currently commented out in HTML)
├── img/
│   ├── logos/              # Brand logos (Sanestone / coach branding)
│   └── about/              # Timeline section images
├── vendor/                 # Third-party CSS/JS/fonts (committed)
├── gulpfile.js             # Local dev build pipeline
└── AGENT.md                # This file
```

Images under `img/` are referenced from HTML but may not all be tracked in git (check before assuming paths exist).

---

## Local development

### Quick preview

Open `index.html` in a browser, or serve the repo root with any static file server. Relative paths assume the site root is `/`.

### Gulp workflow (optional)

If Node.js dependencies are installed (`npm install` — requires a `package.json`; the gulpfile expects one):

```bash
gulp          # Compile LESS, minify CSS/JS, copy vendors
gulp dev      # Watch files + BrowserSync live reload
```

Edit styles in `less/agency.less`, then run `gulp` to regenerate `css/agency.css` and `css/agency.min.css`. Edit behavior in `js/agency.js`, then minify to `js/agency.min.js`.

**Deployment note:** GitHub Pages serves committed files. After building, commit updated `css/` and `js/` artifacts if you changed sources.

---

## Guidelines for agents

### Scope and constraints

- **Keep it static.** Do not add backends, databases, or server frameworks unless the user explicitly requests a architecture change away from GitHub Pages.
- **Preserve bilingual parity.** When editing copy or structure, update **both** `index.html` and `indexen.html` unless the change is language-specific.
- **Respect the business context.** Content is professional coaching for adults in Switzerland; maintain the existing tone and CHF pricing unless asked to change it.
- **Formspree is external.** Changing the form endpoint or fields requires updating the Formspree dashboard configuration as well as the HTML.
- **Custom domain.** Do not remove or rename `CNAME` without coordinating DNS and GitHub Pages settings.

### Common tasks

| Task | Where to work |
|------|----------------|
| Update French copy | `index.html` |
| Update English copy | `indexen.html` |
| Change prices or services | `#prices` / `#services` in both HTML files |
| Style changes | `less/agency.less` → run gulp → `css/agency.css` |
| Navbar / scroll behavior | `js/agency.js` |
| Language switcher | `js/change_language.js`, `js/change_language_en.js` |
| SEO meta tags | `<head>` of each HTML file |
| Add a new static page | New `.html` at repo root + link from nav + sitemap |

### What not to do

- Do not commit `node_modules/` (already gitignored).
- Do not store secrets in the repo (Formspree form ID is public by design; avoid API keys).
- Do not assume Spanish support — legacy references to Spanish (`lang="es"` on `<html>`, `#SpanishLanguage` handlers) exist but the site is FR/EN only.
- Do not add heavy JS frameworks for a simple marketing page unless requested.

---

## Summary

**Suisse Seduction** is a **static, bilingual marketing site** for a **private dating and seduction coach** in Lausanne and Geneva. It explains the coaching methodology, lists services and Swiss-franc pricing, and captures leads through a **Formspree contact form**. It is hosted on **GitHub Pages** at **www.suisseduction.ch**, built on the Bootstrap Agency theme, with optional Gulp-based asset compilation for local development.

---
name: frontend-design
description: >-
  Use when designing or redesigning the UI for suisseduction.ch. Covers
  Figma-based design from scratch, Tailwind CSS implementation, brand identity
  (colors #84d2f7 / #222 / #eee, fonts Montserrat, Roboto Slab, Kaushan
  Script), responsive layout, and accessibility. Trigger keywords: figma,
  tailwind, design, ui, redesign, brand, responsive, mobile, dark mode,
  component, layout, style, modernize, makeover.
---

# Frontend Design Skill — Suisse Seduction

This skill guides the AI agent through designing and implementing a modern, user-friendly UI for the Suisse Seduction website using **Figma** for design and **Tailwind CSS** for implementation. The existing Bootstrap 3 theme is fully replaced.

---

## 1. Design process (Figma from scratch)

When the user requests a design or redesign, follow this workflow:

### 1.1 Discover brand identity

Extract from the codebase and `AGENT.md`:

| Token | Value | Tailwind mapping |
|-------|-------|-----------------|
| Primary | `#84d2f7` | `primary-*` |
| Primary dark | `#2e8bc0` | `primary-dark` |
| Dark bg | `#222222` | `dark` / `gray-900` |
| Darker | `#111111` | `darker` |
| Light bg | `#eeeeee` | `light` / `gray-100` |
| Light accent | `#c9e6ff` | `accent-light` |
| White | `#ffffff` | `white` |
| Body text | `#333333` | `gray-800` |
| Muted | `#777777` | `gray-500` |
| Success | `#28a745` | `success` |
| Danger | `#e74c3c` | `danger` |

Typography:

| Usage | Font | Stack |
|-------|------|-------|
| Headings | Montserrat | `'Montserrat', sans-serif` |
| Body | Roboto Slab | `'Roboto Slab', serif` |
| Decorative | Kaushan Script | `'Kaushan Script', cursive` |
| Nav (heading style) | Montserrat uppercase | — |

### 1.2 Create Figma mockup

Design in this order — single-page scroll layout:

1. **Frame:** Desktop 1440×900, Tablet 768×1024, Mobile 375×667
2. **Navigation bar:** Fixed top, semi-transparent on hero, solid on scroll, dark background (`#222`), white Montserrat uppercase links, logo left, hamburger on mobile
3. **Hero section:** Full-viewport dark overlay on background image, centered headline (Kaushan Script italic), subheading (Montserrat uppercase), CTA button (primary `#84d2f7`). Logo in center or top-left.
4. **About / Timeline section:** Alternating left-right timeline cards, circular numbered/image nodes on center line, light section bg (`#eee`), dark headings
5. **Services section:** 3×2 grid of icon cards (Font Awesome), centered icons in circles, title, short description, white bg
6. **Pricing section:** 3–4 column card grid, featured plan highlighted with primary border/badge, CHF prices prominent, CTA button per card
7. **Contact section:** Dark bg (`#222`), two-column: left info/CTAs (email `info@suisseduction.ch`), right form (name, email, phone, message), primary-color focus rings, white labels
8. **Footer:** Dark bg (`#111`), social icons row, copyright text, email link

Extract design tokens from Figma:
- Colors, typography (size/weight/line-height), spacing (gap/padding/margin), border-radius, box-shadow
- Export assets (background images, icons) if new ones are created

### 1.3 Present design decisions

For any significant design choice, explain:
- How it reflects the premium coaching brand (e.g., dark = sophistication, blue = trust)
- How it improves conversion (e.g., prominent CTA, clear pricing, simple form)
- How it works on mobile

---

## 2. Tailwind CSS setup

### 2.1 Install Tailwind CLI

```bash
npm init -y
npm install tailwindcss @tailwindcss/cli
```

### 2.2 Configure `tailwind.config.js`

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./*.html", "./js/*.js"],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#84d2f7",
          dark: "#2e8bc0",
          light: "#b3e4fa",
        },
        dark: {
          DEFAULT: "#222222",
          darker: "#111111",
        },
        light: {
          DEFAULT: "#eeeeee",
          accent: "#c9e6ff",
        },
        success: "#28a745",
        danger: "#e74c3c",
      },
      fontFamily: {
        heading: ["Montserrat", "sans-serif"],
        body: ["Roboto Slab", "serif"],
        script: ["Kaushan Script", "cursive"],
      },
      spacing: {
        18: "4.5rem",
        88: "22rem",
        128: "32rem",
      },
      borderRadius: {
        xl: "0.75rem",
        "2xl": "1rem",
      },
      boxShadow: {
        card: "0 4px 12px rgba(0,0,0,0.08)",
        "card-hover": "0 8px 24px rgba(0,0,0,0.12)",
        button: "0 2px 8px rgba(132,210,247,0.4)",
      },
      animation: {
        "fade-in": "fadeIn 0.5s ease-out",
        "slide-up": "slideUp 0.5s ease-out",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideUp: {
          "0%": { opacity: "0", transform: "translateY(20px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
      },
    },
  },
  plugins: [],
};
```

### 2.3 Create entry CSS

`css/input.css`:

```css
@import "tailwindcss";

@layer base {
  html {
    scroll-behavior: smooth;
  }
  body {
    @apply font-body text-gray-800 antialiased;
  }
  h1, h2, h3, h4, h5, h6 {
    @apply font-heading font-bold;
  }
}

@layer components {
  .btn-primary {
    @apply inline-block rounded-xl bg-primary px-8 py-3 font-heading
           text-sm font-bold uppercase tracking-wider text-white
           shadow-button transition-all duration-300
           hover:bg-primary-dark hover:shadow-lg;
  }
  .btn-outline {
    @apply inline-block rounded-xl border-2 border-primary px-8 py-3
           font-heading text-sm font-bold uppercase tracking-wider
           text-primary transition-all duration-300
           hover:bg-primary hover:text-white;
  }
  .section-heading {
    @apply mb-4 text-center font-heading text-4xl font-bold uppercase
           text-gray-900;
  }
  .section-subheading {
    @apply mb-16 text-center font-body text-base italic text-gray-500;
  }
}
```

### 2.4 Build

```bash
npx tailwindcss -i ./css/input.css -o ./css/tailwind.css --watch
```

For production (purge unused):

```bash
npx tailwindcss -i ./css/input.css -o ./css/tailwind.css --minify
```

---

## 3. Rebuild HTML with Tailwind (full Bootstrap 3 replacement)

For each section, remove Bootstrap classes (`container`, `row`, `col-md-*`, `btn`, `navbar-default`, etc.) and replace with Tailwind utilities.

### 3.1 Navigation bar

```html
<nav id="mainNav" class="fixed top-0 z-50 w-full bg-dark/90 py-4 transition-all duration-300">
  <div class="mx-auto flex max-w-7xl items-center justify-between px-6">
    <img src="img/image(1).png" alt="Suisse Seduction" class="h-10" />
    <!-- Desktop nav -->
    <div class="hidden items-center space-x-8 md:flex">
      <a href="#about" class="font-heading text-sm font-bold uppercase tracking-wider text-white transition-colors hover:text-primary">Qui suis-je</a>
      <a href="#services" class="font-heading text-sm font-bold uppercase tracking-wider text-white transition-colors hover:text-primary">Services</a>
      <a href="#prices" class="font-heading text-sm font-bold uppercase tracking-wider text-white transition-colors hover:text-primary">Tarifs</a>
      <a href="#contact" class="font-heading text-sm font-bold uppercase tracking-wider text-white transition-colors hover:text-primary">Contact</a>
      <a href="indexen.html" class="font-heading text-sm font-bold uppercase tracking-wider text-primary">EN</a>
    </div>
    <!-- Mobile hamburger -->
    <button class="block text-white md:hidden" onclick="toggleNav()">
      <i class="fa fa-bars text-2xl"></i>
    </button>
  </div>
</nav>
```

Add smooth scroll JavaScript (reuse from `js/agency.js` or rewrite inline):

```js
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
});
```

### 3.2 Hero section

```html
<header id="page-top" class="relative flex min-h-screen items-center justify-center bg-cover bg-center"
        style="background-image: url('img/header-bg.jpg');">
  <div class="absolute inset-0 bg-black/60"></div>
  <div class="relative z-10 px-4 text-center text-white">
    <p class="font-script text-2xl italic md:text-4xl">Bienvenue chez</p>
    <h1 class="mt-4 font-heading text-5xl font-bold uppercase tracking-wider md:text-7xl">Suisse Seduction</h1>
    <p class="mt-6 max-w-2xl font-body text-lg text-gray-200">
      Coaching privé de séduction et drague à Lausanne et Genève
    </p>
    <a href="#contact" class="btn-primary mt-10">Réservez votre appel gratuit</a>
  </div>
</header>
```

### 3.3 About / Timeline

- Replace `.timeline` with a flex/grid column layout
- Alternating cards: `md:flex-row` vs `md:flex-row-reverse`
- Circular image node: `rounded-full border-4 border-primary bg-primary text-white`
- Vertical line on desktop: a `div` with `w-0.5 bg-gray-200 absolute left-1/2`

### 3.4 Services grid

```html
<section id="services" class="bg-white px-6 py-24">
  <div class="mx-auto max-w-6xl">
    <h2 class="section-heading">Services</h2>
    <p class="section-subheading">Un accompagnement complet pour transformer votre vie sentimentale</p>
    <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
      <div class="card rounded-2xl bg-white p-8 text-center shadow-card transition-shadow hover:shadow-card-hover">
        <div class="mx-auto mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-primary/10">
          <i class="fa fa-book text-3xl text-primary"></i>
        </div>
        <h3 class="mb-3 font-heading text-xl font-bold">Théorie simplifiée</h3>
        <p class="font-body text-gray-600">Guide exclusif avec la méthode du coach.</p>
      </div>
      <!-- Repeat for other 5 services -->
    </div>
  </div>
</section>
```

### 3.5 Pricing table

```html
<section id="prices" class="bg-light px-6 py-24">
  <div class="mx-auto max-w-6xl">
    <h2 class="section-heading">Tarifs</h2>
    <p class="section-subheading">Investissez dans votre transformation — en CHF</p>
    <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
      <!-- Price card template -->
      <div class="rounded-2xl bg-white p-6 text-center shadow-card">
        <h3 class="font-heading text-lg font-bold uppercase text-gray-900">Service name</h3>
        <p class="mt-4 font-heading text-4xl font-bold text-primary">Prix</p>
        <p class="mt-2 font-body text-sm text-gray-500">Description</p>
        <a href="#contact" class="btn-outline mt-6">Réserver</a>
      </div>
    </div>
    <p class="mt-8 text-center font-body text-sm text-gray-500">
      Les 20 premières minutes d'appel sont offertes.
    </p>
  </div>
</section>
```

### 3.6 Contact form

```html
<section id="contact" class="relative bg-dark bg-cover bg-center px-6 py-24"
         style="background-image: url('img/map-image.png');">
  <div class="absolute inset-0 bg-dark/85"></div>
  <div class="relative z-10 mx-auto max-w-4xl">
    <h2 class="section-heading text-white">Contactez-moi</h2>
    <p class="section-subheading text-gray-400">Premier appel offert — sans engagement</p>
    <form action="https://formspree.io/f/xqaawzdl" method="POST" class="grid gap-6 md:grid-cols-2">
      <div class="md:col-span-1">
        <label class="mb-1 block font-heading text-sm font-bold uppercase tracking-wider text-white">Nom *</label>
        <input type="text" name="name" required
               class="w-full rounded-xl bg-white/10 px-5 py-4 font-body text-white placeholder-gray-400
                      backdrop-blur-sm transition-all duration-200 focus:bg-white/20 focus:outline-none focus:ring-2 focus:ring-primary" />
      </div>
      <div class="md:col-span-1">
        <label class="mb-1 block font-heading text-sm font-bold uppercase tracking-wider text-white">Email *</label>
        <input type="email" name="email" required
               class="w-full rounded-xl bg-white/10 px-5 py-4 font-body text-white placeholder-gray-400
                      backdrop-blur-sm transition-all duration-200 focus:bg-white/20 focus:outline-none focus:ring-2 focus:ring-primary" />
      </div>
      <div class="md:col-span-1">
        <label class="mb-1 block font-heading text-sm font-bold uppercase tracking-wider text-white">Téléphone</label>
        <input type="tel" name="phone"
               class="w-full rounded-xl bg-white/10 px-5 py-4 font-body text-white placeholder-gray-400
                      backdrop-blur-sm transition-all duration-200 focus:bg-white/20 focus:outline-none focus:ring-2 focus:ring-primary" />
      </div>
      <div class="md:col-span-2">
        <label class="mb-1 block font-heading text-sm font-bold uppercase tracking-wider text-white">Message *</label>
        <textarea name="message" rows="5" required
                  class="w-full rounded-xl bg-white/10 px-5 py-4 font-body text-white placeholder-gray-400
                         backdrop-blur-sm transition-all duration-200 focus:bg-white/20 focus:outline-none focus:ring-2 focus:ring-primary"></textarea>
      </div>
      <div class="md:col-span-2 text-center">
        <button type="submit" class="btn-primary">Envoyer</button>
      </div>
    </form>
    <p class="mt-6 text-center font-body text-sm text-gray-400">
      Ou écrivez-moi directement à <a href="mailto:info@suisseduction.ch" class="text-primary underline">info@suisseduction.ch</a>
    </p>
  </div>
</section>
```

### 3.7 Footer

```html
<footer class="bg-dark-darker px-6 py-12">
  <div class="mx-auto max-w-6xl text-center">
    <div class="mb-6 flex justify-center space-x-4">
      <a href="#" class="flex h-10 w-10 items-center justify-center rounded-full bg-dark text-white transition-colors hover:bg-primary">
        <i class="fa fa-facebook"></i>
      </a>
      <a href="#" class="flex h-10 w-10 items-center justify-center rounded-full bg-dark text-white transition-colors hover:bg-primary">
        <i class="fa fa-instagram"></i>
      </a>
      <a href="mailto:info@suisseduction.ch" class="flex h-10 w-10 items-center justify-center rounded-full bg-dark text-white transition-colors hover:bg-primary">
        <i class="fa fa-envelope"></i>
      </a>
    </div>
    <p class="font-body text-sm text-gray-400">
      &copy; 2024 Suisse Seduction. Tous droits réservés.
    </p>
    <p class="mt-1 font-body text-sm text-gray-500">
      <a href="mailto:info@suisseduction.ch" class="text-primary hover:underline">info@suisseduction.ch</a>
    </p>
  </div>
</section>
```

---

## 4. Component design patterns

Reusable component recipes for consistency:

### Buttons
- `btn-primary` → solid `primary` bg, white text, uppercase, rounded-xl, shadow-button, hover lifts
- `btn-outline` → primary border, primary text, hover fills primary
- `btn-ghost` → no bg/border, primary text, hover underline

### Cards
- Service card: `rounded-2xl bg-white p-8 shadow-card hover:shadow-card-hover text-center`, icon circle, title `font-heading text-xl font-bold`, body `font-body text-gray-600`
- Pricing card: same shape, price `font-heading text-4xl font-bold text-primary`, CTA at bottom
- Timeline card: `flex md:flex-row md:flex-row-reverse items-center gap-6`, image node `rounded-full`, panel `rounded-2xl bg-white p-6 shadow-card`

### Section headings
- `h2.section-heading`: uppercase, centered, `text-4xl`, `font-heading`, `text-gray-900`
- `p.section-subheading`: italic, centered, `font-body`, `text-base`, `text-gray-500`, bottom margin

### Form inputs
- Shared class set: `w-full rounded-xl bg-white/10 px-5 py-4 font-body text-white placeholder-gray-400 backdrop-blur-sm transition-all duration-200 focus:bg-white/20 focus:outline-none focus:ring-2 focus:ring-primary`
- Inside a `<label>` wrapper with `font-heading text-sm font-bold uppercase tracking-wider`

---

## 5. Responsive design

Implement mobile-first:

| Breakpoint | Width | Layout changes |
|------------|-------|---------------|
| Default (mobile) | < 768px | Single column, stacked cards, hamburger nav, reduced font sizes |
| `md:` | ≥ 768px | Side-by-side services (2-col), timeline alternating, 2-col pricing |
| `lg:` | ≥ 1024px | 3-col services, 4-col pricing, full timeline with center line |
| `xl:` | ≥ 1280px | Max container width, larger spacing |

Always test:
- Navbar collapse/expand on mobile
- Touch target sizes (min 44×44px for buttons/links)
- Form readability on mobile
- Timeline vertical stacking on mobile (single line on left)

---

## 6. Migration checklist (removing Bootstrap 3)

When replacing Bootstrap with Tailwind, do this methodically:

1. Add Tailwind CSS to `<head>`: `<link href="css/tailwind.css" rel="stylesheet" />`
2. Remove from `<head>`: `vendor/bootstrap/css/bootstrap.min.css`, `css/agency.css`, `css/style.css`
3. Remove from `<body>` end: all Bootstrap JS (`vendor/bootstrap/js/bootstrap.min.js`, etc.)
4. Keep: `vendor/jquery/jquery.min.js`, `vendor/font-awesome/css/font-awesome.min.css`, `js/agency.js` (or replace with inline scroll), `js/jqBootstrapValidation.js`, language switcher scripts
5. Replace all Bootstrap classes (`container`, `row`, `col-*`, `btn`, `navbar-*`, `form-control`, `panel`, `well`, `table`, etc.) with Tailwind equivalents
6. Test every section in both languages

### Classes to map

| Bootstrap | Tailwind replacement |
|-----------|---------------------|
| `container` | `mx-auto max-w-7xl px-6` |
| `row` | `flex flex-wrap` or `grid grid-cols-*` |
| `col-md-6` | `w-full md:w-1/2` |
| `col-md-4` | `w-full md:w-1/2 lg:w-1/3` |
| `col-md-3` | `w-full md:w-1/2 lg:w-1/4` |
| `text-center` | `text-center` (same) |
| `text-uppercase` | `uppercase` (same) |
| `text-muted` | `text-gray-500` |
| `btn btn-primary` | `btn-primary` (custom component class) |
| `btn btn-xl` | `btn-primary text-lg px-10 py-5` |
| `navbar-fixed-top` | `fixed top-0 z-50 w-full` |
| `bg-light-gray` | `bg-light` or `bg-gray-100` |
| `bg-darkest-gray` | `bg-dark` |
| `form-control` | `w-full rounded-xl px-5 py-4 ...` (custom) |
| `navbar-toggle` | `block md:hidden ...` + hamburger icon |

---

## 7. Bilingual parity

Every change must be applied to **both** `index.html` (French) and `indexen.html` (English):
- Same Tailwind utility classes in both files
- Same layout structure
- Different text content (FR / EN)
- Different `<title>` and `<meta description>`
- Language switcher buttons point to the opposite file
- The English nav link should read "FR" (redirects to `index.html`)
- The French nav link should read "EN" (redirects to `indexen.html`)

---

## 8. Accessibility

- **Color contrast:** Primary `#84d2f7` on dark bg `#222` → contrast ratio ~4.2:1 (meets AA for large text). Use white text on dark bg for body content. For small text, use a darker variant (`#2e8bc0` primary-dark).
- **Focus states:** All interactive elements must have visible `focus:ring-2 focus:ring-primary` (already included in component patterns).
- **Semantic HTML:** Use `<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`, `<h1>`–`<h3>` in correct hierarchy.
- **Alt text:** Every `<img>` must have a descriptive `alt` attribute.
- **Reduced motion:** Wrap animations in `@media (prefers-reduced-motion: reduce)`.
- **Touch targets:** Minimum 44×44px for all interactive elements on mobile.

---

## 9. Deployment

After building:
```bash
npx tailwindcss -i ./css/input.css -o ./css/tailwind.css --minify
```

The output `css/tailwind.css` is committed to the repo — GitHub Pages serves it directly. No build step is required on the server.

---

## 10. Constraints

- **Keep it static.** No backends, databases, PHP, or SSR.
- **No JS framework.** No React, Vue, Svelte, etc.
- **Preserve CNAME.** Do not remove or modify `CNAME`.
- **Formspree endpoint.** Do not change `https://formspree.io/f/xqaawzdl`.
- **No Spanish support.** The site is FR/EN only despite `lang="es"` legacy.
- **Vendors stay.** Font Awesome is committed in `vendor/font-awesome/` — keep serving from there or replace with a CDN link.

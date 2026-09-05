# LucioSunj.github.io

Personal academic homepage of **Jun Sun (孙俊)** — bilingual (English / 中文), built with
plain Jekyll so it works on GitHub Pages with no build workflow.

Live: <https://luciosunj.github.io>

---

## How it is put together

Almost nothing lives in the HTML. Every piece of content is a YAML file in `_data/`,
and the pages are thin front-matter stubs that pick a layout and a language.

```
_data/
  profile.yml        name, eyebrow, hero headline, bio, goal, research focus, chips
  news.yml           the "News / 近况" list
  publications.yml   papers (set `selected: true` to show one on the homepage)
  research.yml       research experience
  experience.yml     internships / jobs
  education.yml      degrees
  awards.yml         scholarships and prizes
  skills.yml         skills table
  i18n.yml           every UI string, in both languages

_layouts/            default · home · publications · cv
_includes/           head · masthead · footer · socials · publication · entry · edu
assets/css/style.css the whole stylesheet (light + dark, responsive, print)
assets/img/          profile.jpg (placeholder portrait — replace it) · favicon.svg
files/               Jun_Sun_CV.pdf

index.html  publications.html  cv.html          ← English pages
zh/index.html  zh/publications.html  zh/cv.html ← Chinese pages
```

Each page declares `lang: en` or `lang: zh` and an `alt_url` pointing at its
counterpart — that is all the language switch in the top-right corner does.
Every data entry carries an `en:` and a `zh:` value, and the layouts read
`item.field[page.lang]`.

## Editing

**Add a paper** — append an entry to `_data/publications.yml`. `selected: true`
also lists it on the homepage.

**Add a news line** — prepend to `_data/news.yml`.

**Add a position** — `_data/research.yml` or `_data/experience.yml`. The `sort_key`
(`YYYY-MM`) is what merges both files into one timeline on the homepage.

**Change wording of a section heading, in either language** — `_data/i18n.yml`.

> ⚠️ Keep Chinese strings on a **single line**. YAML's folded style (`>`) inserts a
> space at every line break, which shows up as a visible gap in CJK text.

**Replace the portrait** — overwrite `assets/img/profile.jpg` with your own photo.
A 4:5 portrait works best; nothing else needs changing. Blank out `author.photo`
in `_config.yml` to fall back to the gradient monogram instead.

**Change the hero headline** — `hero_lines` in `_data/profile.yml`. The line with
`accent: true` is the one rendered in the violet gradient.

**Card labels** — publications use `tile_label` (e.g. `IROS`), positions and degrees
use `initials` (e.g. `NJU`, `XJTLU`). A publication can also set `thumb:` to a teaser
image path, which replaces the label tile.

## Logos

Every card shows a logo plate on the left, read from the `logo:` field of the
matching `_data/*.yml` entry.

```bash
bash scripts/fetch-logos.sh      # run this on your own machine
```

That pulls the official XJTLU, NJU and IROS marks straight from their sites into
`assets/img/logos/`. Anything it cannot fetch keeps the current file, so it is
safe to re-run.

| File | Used by | Status |
| --- | --- | --- |
| `xjtlu.png` | XJTLU degree + the three XJTLU positions | ✓ real crest |
| `iros.webp` | both IROS 2026 papers | ✓ real logo |
| `westlake.webp` | Westlake Robotics internship | ✓ real logo |
| `nju.png` | Nanjing University position | placeholder — `fetch-logos.sh` pulls the official one |
| `indin.svg` | INDIN 2025 paper | placeholder wordmark (fine as is) |

The NJU school lockup only exists as white-on-transparent, so that entry sets
`logo_dark: true`, which puts its tile on a dark plate. Add the same line to any
other entry whose logo is white; remove it if you swap in a dark version.

SVG is preferred; a transparent PNG at 200×200 or larger works too — just change
the `logo:` path if the extension differs. Remove an entry's `logo:` field
entirely to fall back to the text tile.

## Colours

The whole palette is ~20 CSS custom properties in the two `:root` blocks at the
top of `assets/css/style.css` — a claret accent on warm paper. Nothing else in
the stylesheet hard-codes a colour, so changing those tokens repaints the site.

Three alternates ship as override files. Set one in `_config.yml`:

```yaml
palette          : "navy"     # "" | navy | forest | violet
```

| Value | Accent | Feel |
| --- | --- | --- |
| `""` (default) | `#8a2f39` claret on `#fdfcfa` warm paper | university press |
| `navy` | `#1b3a6b` on white | institutional; matches the XJTLU crest |
| `forest` | `#1f4d3d` on white | formal, less common than navy |
| `violet` | `#5b4bf0` | the original draft — brighter, more startup |

The override loads after `style.css` and only redefines tokens, so a blank or
misspelled value just falls back to claret.

Two knobs do most of the work if you roll your own: `--accent` is every link,
heading rule and pill, and `--cta-a` is the Contact block. Setting `--accent-2`
equal to `--accent` (and `--cta-b` to `--cta-a`) collapses every gradient in the
stylesheet into a flat fill — that, more than the hue, is what makes the page
read as formal rather than as a product landing page. `--wash-a` / `--wash-b`
are the tint behind the top of the page; keep them under about 8% opacity.

## Running it locally

```bash
bundle install
bundle exec jekyll serve      # http://127.0.0.1:4000
```

## Deploying

GitHub Pages builds `main` automatically — push and it is live in a minute or two.
No Actions workflow needed.

## To do

- [ ] Replace `assets/img/profile.jpg` with a real photo
- [ ] Run `bash scripts/fetch-logos.sh`, then add a Westlake Robotics logo by hand
- [ ] Add Google Scholar / ORCID links in `_config.yml`
- [ ] Re-export `files/Jun_Sun_CV.pdf` once the CV includes the Nanjing University position
- [ ] Fill in exact months for the two `2026` / `2025` news items

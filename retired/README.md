# Retired: the old generated press page

`press/` is the press page the app repo's `tools/media_harness/press.py` used to generate into
`public/press/` (the page, its icon and 80 media files, 198 MB). Since 2026-11-18 weatherie.com/press and
/drafts are the shared Advection press app reading `gs://advection-media/weatherie`, so this copy is no
longer deployed: it sits outside `public/`, and Astro only ships `public/` and `src/`.

It is kept, untouched, until the old storage is retired across every app (brain `media-platform.md`,
"Moving an app over", step 7). Nothing reads it. Don't add to it; new media goes through the `media`
command (`~/Projects/advection-media`).

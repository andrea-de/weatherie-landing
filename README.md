# Weatherie Landing

This repo contains the Astro landing site for Weatherie.

It is a static marketing site with:
- the main landing page in `src/pages/index.astro`
- a locally embedded Flutter demo served from `public/demo`
- a build script that regenerates that demo from the sibling Flutter app

## Local Development

From `landing/`:

```sh
npm install
npm run dev
```

Astro runs at `http://localhost:4321`.

## Flutter Demo Workflow

The landing page embeds a generated Flutter web demo. That demo is not source-authored in this repo; it is built from the sibling Flutter project at `../flutter`.

To rebuild and sync the demo bundle:

```sh
npm run build:demo
```

That runs:
- `../flutter/scripts/build_demo_web.sh --base-href /demo/`
- `rsync` into `public/demo/`

## Build Commands

```sh
npm run build
```

Builds only the Astro site.

```sh
npm run build:deploy
```

Builds the Flutter demo first, then builds the Astro site.

Use `build:deploy` for production output when the embedded demo has changed.

## Repo Notes

- `public/demo/` is generated from the sibling Flutter repo.
- If this landing repo is deployed by itself on Vercel, `public/demo/` must be present in the repo or the `/demo/...` embeds will 404.
- This repo expects the Flutter app repo to exist at `../flutter` if you use `build:demo` or `build:deploy`.
- The landing page currently uses one full app preview plus a generated hourly demo scene from Flutter.

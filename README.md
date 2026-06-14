# divyangchauhan.github.io

Static mirror of [divyang.dev](https://divyang.dev), Divyang Chauhan's portfolio website.

The editable source code lives in the sibling React/Vite repo:

```text
../divyang.dev
```

This repository stores the built static output that can be served by GitHub Pages or kept as a public mirror.

## Update This Repo

After changing the React site in `../divyang.dev`, run:

```bash
./scripts/sync-from-react.sh
```

The sync script builds the source repo, copies its `dist/` output here, preserves this README and the sync script, and adds the GitHub Pages helpers:

- `.nojekyll`
- `404.html`
- `resume/index.html`

Then commit and push:

```bash
git status
git add .
git commit -m "Update website"
git push
```

## Notes

The live custom-domain site is hosted at [divyang.dev](https://divyang.dev). GitHub Pages is optional for this repository.

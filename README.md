# TUF Slots

A single-page, zombie-arcade slot machine played with fun money (TUF). No real money, no purchases.

## Play
Open `index.html` in any modern browser, or host it with GitHub Pages (below).

## Controls
- **Start** (or Space/Enter): spin
- **Up / Down**: change bet (1, 2, 5, 10)
- **Present key** (or Left arrow): buy a mystery box with 5 free spins
- **Blue arrow key** (or Right arrow): auto spin 10 / 50 / 100, with optional Turbo
- **TURBO** (under the spin counter): faster spins
- **reset**: restore the balance to 500 TUF
- **?** and speaker (bottom left): rules and sound on/off
- Tap falling perk bottles for a multiplier on your next spin

Progress is saved in your browser (localStorage).

## Host on GitHub Pages
1. Create a new repository and upload `index.html` and this `README.md` to the root.
2. Go to **Settings > Pages**.
3. Under **Build and deployment**, set Source to **Deploy from a branch**, pick `main` and `/ (root)`, then **Save**.
4. After a minute the game is live at `https://<your-username>.github.io/<repo-name>/`.

## Notes
- Everything (art, code, styles) is inside `index.html`. The only outside request is Google Fonts; without a connection the page falls back to system fonts.

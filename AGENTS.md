# Base Agentic Ecosystem

## Project Overview

Telemetry dashboard tracking early signals of AI agent economy on Base (L2). Built with Dune Analytics SQL queries + markdown text widgets. Monitors identity registrations (ERC-8004), token launchpad activity (Virtuals, Clanker), agent-adjacent tooling (Venice, Bankr), and cross-chain comparison (Base vs Solana).

- **Live dashboard:** https://dune.com/ax1research/base-agentic-ecosystem
- **Platform:** Dune Analytics (DuneSQL / Trino)
- **Chain:** Base mainnet (+ Solana for comparison)
- **Supported by:** [AX1 Community](https://twitter.com/AX1ecosystem)

## Project Structure

```
base-agentic-ecosystem/
  AGENTS.md                                    # Project rules and context (this file)
  docs/
    BASE_AGENTIC_DASHBOARD_INSTRUCTIONS_RU.md  # Full dashboard guide (Russian) — all queries + widget setup
    DASHBOARD_V1_UPDATE_GUIDE.md               # V1 iteration changes — what to update on the live dashboard
    OWB_POOL_RESEARCH_DEC_4_10_2025.md         # Standalone research: OWB token pool analysis
```

## Dashboard Sections

| Section | Query | What It Tracks |
|---------|-------|---------------|
| Ecosystem Pulse | Query 1 | 6 KPIs: Total Txs, Unique Addresses, ERC-8004 Agents, WoW dynamics, Infra vs Consumer |
| Cross-Pollination Index | Query 1b | Network effect: Power Users (3+ projects), Avg Projects/User, Single-Project % |
| Daily Activity | Query 2 | Daily transaction trends, active addresses, cumulative growth |
| Leaderboard | Query 3 | Activity Score ranking (55% Txs + 45% Users), WoW momentum, holders |
| ERC-8004 Registry | Query 4a/4b | Agent identity registrations, creator concentration |
| Virtuals Protocol | Query 5 | Token economics, trading activity, agent token health |
| Base vs Solana | Query 6/7 | Head-to-head: DEX volume, traders, avg trade size, growth dynamics |

## Tracked Contracts

### Base — Infrastructure
| Project | Address |
|---------|---------|
| Virtuals Protocol | `0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b` |
| Spectral | `0x96419929d7949d6a801a6909c145c8eef6a40431` |
| Clanker | `0x1bc0c42215582d5a085795f4badbac3ff36d1bcb` |
| Venice | `0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf` |
| AIXBT | `0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825` |

### Base — Consumer
| Project | Address |
|---------|---------|
| AWE | `0x1b4617734c43f6159f3a70b7e06d883647512778` |
| FAI | `0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935` |
| VADER | `0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870` |
| CLAWD | `0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07` |
| Bankr | `0x22af33fe49fd1fa80c7149773dde5890d3c76f3b` |
| Ribbita | `0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00` |

### Standards
| Standard | Address / Status |
|----------|-----------------|
| ERC-8004 (Agent Identity Registry) | `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` |
| x402 (HTTP-native agent payments) | Not yet measurable onchain at scale |

### Solana — Comparison Tokens
| Token | Mint Address |
|-------|-------------|
| ai16z (elizaOS) | `HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC` |
| Fartcoin | `9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump` |
| GOAT | `CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump` |
| ARC | `61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump` |
| Zerebro | `8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn` |
| GRIFFAIN | `KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP` |
| VIRTUAL (SOL) | `3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y` |

## Code Standards

### SQL (DuneSQL / Trino)
- All queries use **DuneSQL** (Trino-based) syntax
- Use CTEs (`WITH ... AS`) for readability — no deeply nested subqueries
- Always qualify table names: `base.transactions`, `base.logs`, `dex.trades`, `dex_solana.trades`
- Solana DEX data lives in `dex_solana.trades` (NOT `dex.trades WHERE blockchain = 'solana'`)
- Solana columns differ: `token_bought_mint_address`, `token_sold_mint_address`, `trader_id`
- EVM columns: `token_bought_address`, `token_sold_address`, `taker`
- Use `ROUND()` for all displayed numbers
- Use `NULLIF(..., 0)` to avoid division by zero
- ERC-8004 registrations: use `base.logs` with topic0 `0xca52e62c...` (Registered event), NOT Transfer events
- Prefer `dex.trades` (Spellbook) over raw byte parsing (`varbinary_to_int256 / 1e18`) — Spellbook has pre-decoded amounts

### Activity Score Formula
```
Score = 55% × (project_txs / max_txs) + 45% × (project_users / max_users)
```
- Each component normalized to top performer (max = 100)
- No ETH Volume component (removed in V1 iteration)

### Markdown (Dashboard Text Widgets)
- Dashboard text widgets use standard Markdown
- English language for all dashboard-facing text
- Russian language for internal documentation / instructions
- File names: **always English**, never Cyrillic

## Workflows

### Adding a New Query
1. Write SQL in DuneSQL syntax using CTEs
2. Test on Dune Query Editor
3. Document in `docs/BASE_AGENTIC_DASHBOARD_INSTRUCTIONS_RU.md`:
   - Query purpose, questions answered
   - Full SQL code
   - Visualization setup (chart type, axes, colors)
   - Widget placement on dashboard layout map

### Updating the Live Dashboard
1. Document changes in `docs/DASHBOARD_V1_UPDATE_GUIDE.md` (what to replace/add)
2. Include old text (to find on Dune) and new text (to paste)
3. If SQL changes — include full new SQL with explanation of what changed
4. Update summary table at bottom of guide

### Adding a New Tracked Project
1. Add contract address to `agentic_contracts` CTE in Queries 1, 2, 3
2. Add to Project Classification table in Methodology widget
3. Verify it meets Inclusion Criteria:
   - Onchain presence on Base with measurable activity
   - Community-identified as "agentic"
   - 100+ transactions in last 30 days
   - Not purely a meme token

### Color Palette
| Element | HEX |
|---------|-----|
| Infrastructure | `#3B82F6` (Blue) |
| Consumer/Agents | `#8B5CF6` (Purple) |
| ERC-8004 / Growth | `#10B981` (Green) |
| Volume/Money | `#F59E0B` (Amber) |
| Cumulative lines | `#1E40AF`, `#6D28D9` (Dark variants) |
| Decline/Negative | `#EF4444` (Red) |

## Tools & Integrations

- **Dune Analytics** — query engine (DuneSQL/Trino), visualization, dashboard hosting
- **Dune Spellbook** — curated decoded tables (`dex.trades`, `tokens.transfers`, etc.)
- **Base mainnet** — primary chain data (`base.transactions`, `base.logs`)
- **Solana** — comparison chain data (`dex_solana.trades`)
- **GitHub** — version control for documentation and query source

## Known Limitations

- **Concentration risk:** Some tokens have high supply concentration (e.g., Clanker ~70% on 5 addresses)
- **"Agentic" is generous:** Most tracked projects are infrastructure or narrative bets, not autonomous agents
- **Off-chain activity not captured:** API calls, LLM inference, social media automation
- **Token ≠ Agent:** Token activity is a proxy for ecosystem attention, not agent autonomy
- **No revenue data:** Agent business models not standardized enough to compare

---

## For AI Agents

This `AGENTS.md` is the **primary source of project rules and context**. When working on tasks in this repository:

- Treat these rules as priority constraints
- All SQL must follow DuneSQL standards described above
- Never use `dex.trades WHERE blockchain = 'solana'` — use `dex_solana.trades`
- Never parse raw bytes when Spellbook decoded tables are available
- File names must always be in English (no Cyrillic)
- Dashboard text widgets are in English; documentation/instructions are in Russian
- Activity Score = 55% Txs + 45% Users (no Volume component)
- ERC-8004 agent count uses `base.logs` Registered event (topic0 `0xca52e62c367d81bb2e328eb795f7c7ba24afb478408a26c0e201d155c449bc4a`), not Transfer events
- When adding projects, update ALL queries that reference `agentic_contracts` CTE
- Always create new PRs for changes (do not amend existing PRs)

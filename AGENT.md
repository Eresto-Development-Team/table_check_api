# AGENT.md: TableCheck POS v1 API Wrapper Gem

This document outlines the architecture, implementation rules, and testing strategies for constructing the `table_check_api` Ruby gem.

---

## 1. Project Parameters & Environment

* **Target Language / Version:** Ruby 2.6 and above.
    * *Implementation Note:* Do not use syntax added in newer Ruby versions (e.g., target-less pattern matching, shorthand hash punning `{a:}`, or endless method definitions `def method = expression`). Use standard keyword arguments and hash syntaxes compatible with Ruby 2.6.
* **API Target:** TableCheck POS v1 API (`https://tablecheck.atlassian.net/wiki/spaces/API/pages/44958898/POS+v1`).
* **Base URL Context:** Production default is `https://api.tablecheck.com/api` (or variant defined by enterprise application specs).
* **Dependencies:** Uses `httparty` as the core HTTP client for simplified REST communications, alongside standard library components (`json`, `uri`, `cgi`).
* **Testing Framework:** `Minitest` (bundled with Ruby or explicit standard dependency) using built-in `Minitest::Mock` or procedural closure stubs. **No external network connections or socket operations are permitted in the test suite.**

---

## 2. Gem File Structure

```text
table_check_api/
├── Gemfile
├── Gemfile.lock
├── table_check_api.gemspec
├── README.md
├── AGENT.md
├── lib/
│   ├── table_check_api.rb          # Connection engine, header management, namespace initialization
│   ├── generators/                 # Rails generators
│   │   ├── table_check_api/
│   │   │   └── install_generator.rb
│   │   └── templates/
│   │       └── table_check_api.rb  # Config initializer template
│   └── table_check_api/
│       ├── configuration.rb        # API configuration (base_url, key)
│       ├── version.rb              # Constant containing gem version
│       └── pos/
│           └── v1/
│               ├── pos_journals.rb # Handlers for POS journals
│               ├── shop.rb         # Handlers for shops
│               └── table.rb        # Handlers for tables
└── test/                           # (Pending tests)
    └── ...
```

## 3. Core API Contract & Resource Routing

The wrapper covers the following endpoints from the POS v1 specification:

### Shops Resource

* `GET /shops` ➡ `TableCheckApi::Pos::V1::Shop.list` — List accessible restaurant/venue operations.

### Tables Resource

* `GET /shops/:shop_id/tables` ➡ `TableCheckApi::Pos::V1::Table.list(shop_id)` — List all tables for a specific shop.
* `GET /shops/:shop_id/table_status/show` ➡ `TableCheckApi::Pos::V1::Table.status(shop_id)` — Show the status of requested table for a specific shop.

### POS Journals Resource

* `POST /shops/:shop_id/pos_journals` ➡ `TableCheckApi::Pos::V1::PosJournals.create(shop_id, payload)` — Post modern billing payload data from the local register matrix.
* `PUT /shops/:shop_id/pos_journals/:id` ➡ `TableCheckApi::Pos::V1::PosJournals.update(shop_id, id, payload)` — Perform correction modifications or structural state transformations.
* `DELETE /shops/:shop_id/pos_journals/:id` ➡ `TableCheckApi::Pos::V1::PosJournals.delete(shop_id, id)` — Structural transaction rollback.
* `POST /shops/:shop_id/pos_journals/void` ➡ `TableCheckApi::Pos::V1::PosJournals.void(shop_id, payload)` — Explicit system-wide processing flags to invalidate existing ledger logs.

---

## 4. Connection & Error Strategy

* **Client Engine:** `TableCheckApi::Client` (in `lib/table_check_api.rb`) acts as the primary HTTP wrapper using `HTTParty`.
* **Header Management:** Global defaults (`User-Agent:TableCheckAPIClient-vx.y.z`, `Accept: application/json`, `Content-Type: application/json`, `Authorization: Bearer <key>`) are attached to every request automatically. Service classes can pass a custom `headers` hash to override these defaults on a per-request basis.
* **Error Handling:** Method calls currently return raw `HTTParty::Response` objects. The calling application is responsible for inspecting `.success?` and handling `4xx/5xx` HTTP codes appropriately, unless explicit error wrapping is built into the service classes later.

# Contest Mode (Linux Competitive Programming Environment)

This project creates a **contest mode** for Ubuntu/Linux that blocks all internet access except specific competitive programming platforms. It helps prevent searching for solutions during practice or contests.

Currently allowed platforms:

* Codeforces
* AtCoder
* HackerRank

Everything else (Google, Bing, ChatGPT, StackOverflow, YouTube, etc.) is blocked while contest mode is enabled.

---

# Features

* Toggle internet restrictions with a simple command
* Blocks search engines and AI tools
* Allows only contest platforms
* Safe to disable (restores normal internet)
* Simple setup
* Lightweight (uses iptables only)

Commands available after setup:

```
contest on
contest off
contest status
```

---

# Requirements

The setup script installs required packages automatically.

Required package:

* `dnsutils` (provides the `dig` command)

Ubuntu already includes:

* `iptables`

---

# Installation

Clone or download the project.

Run the setup script:

```
chmod +x setup-contest-mode.sh
./setup-contest-mode.sh
```

This script will:

1. Install required packages
2. Create the `contest` command
3. Configure the system

After setup you can use the contest command anywhere.

---

# Usage

Enable contest mode:

```
contest on
```

Disable contest mode:

```
contest off // won't work
```

Check current status:

```
contest status
```

---

# Allowed Websites

When contest mode is enabled, only these websites are accessible:

```
codeforces.com
atcoder.jp
hackerrank.com
```

All other websites will be blocked.

---

# How It Works

The system uses `iptables` firewall rules.

When contest mode is enabled:

* All outgoing traffic is blocked
* DNS is allowed
* Only IP addresses of allowed domains are permitted

When contest mode is disabled:

* Firewall rules are removed
* Internet access returns to normal

---

# Safety

The script ensures:

* Internet is restored using `contest off`
* Maybe only `contest off` won't help, oppss... dm me to know how to do
* No permanent system modifications
* No DNS configuration changes
* Firewall rules are reset properly

If something goes wrong you can manually restore internet with:

```
sudo iptables -F
sudo iptables -P OUTPUT ACCEPT
```

---

# Customization

You can modify allowed platforms by editing the domain list inside the `contest` script:

```
ALLOWED_DOMAINS=("codeforces.com" "atcoder.jp" "hackerrank.com")
```

Add additional platforms if needed.

Example:

```
ALLOWED_DOMAINS=("codeforces.com" "atcoder.jp" "hackerrank.com" "kattis.com")
```

---

# Notes

Some websites use many IP addresses (CDN networks). If a site occasionally fails to load, it may require additional domain allowances.

---

# Purpose

This tool is intended for:

* Competitive programming practice
* Distraction-free coding sessions
* Self-imposed contest rules

---

# License

Free to use and modify.

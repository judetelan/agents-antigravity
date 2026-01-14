# Agents for Antigravity

> 🚀 **221 Skills** + **63 Workflows** for Google Antigravity

A comprehensive collection of Antigravity-compatible skills and workflows, converted from the [wshobson/agents](https://github.com/wshobson/agents) Claude Code plugin ecosystem.

## 📂 Structure

```
agents-antigravity/
├── skills/                  # 221 Antigravity Skills
│   ├── python-pro/
│   │   └── SKILL.md
│   ├── backend-architect/
│   │   └── SKILL.md
│   ├── async-python-patterns/
│   │   └── SKILL.md
│   └── ... (218 more)
├── workflows/               # 63 Slash-Command Workflows
│   ├── python-scaffold.md
│   ├── full-stack-feature.md
│   ├── security-hardening.md
│   └── ... (60 more)
└── plugins/                 # Original Claude Code format (preserved)
```

## ⚡ Quick Install (Global)

To make all skills available globally across all Antigravity workspaces:

```powershell
# Windows
Copy-Item -Recurse "skills\*" "$HOME\.gemini\antigravity\skills\"
Copy-Item -Recurse "workflows\*" "$HOME\.gemini\antigravity\workflows\" -Force
```

```bash
# macOS/Linux
cp -r skills/* ~/.gemini/antigravity/skills/
cp -r workflows/* ~/.gemini/antigravity/workflows/
```

## 🎯 How It Works

### Automatic Skill Activation

Skills activate automatically based on user intent:

```
User: "Build a FastAPI service with async database connections"

[Antigravity activates: async-python-patterns, fastapi-pro, api-design-principles]

Agent: "I'll help you build this using modern async patterns..."
```

### Workflow Invocation

Workflows are invoked via slash commands:

```
User: "/python-scaffold"

Agent: "Let's create your Python project. What type...?"
```

## 📋 Skill Categories

| Category | Count | Examples |
|----------|-------|----------|
| **Python** | 12+ | `python-pro`, `async-python-patterns`, `fastapi-pro` |
| **Backend** | 15+ | `backend-architect`, `api-design-principles`, `graphql-architect` |
| **JavaScript/TypeScript** | 10+ | `typescript-pro`, `nextjs-app-router-patterns` |
| **DevOps/Cloud** | 20+ | `kubernetes-architect`, `terraform-specialist`, `cloud-architect` |
| **Security** | 10+ | `security-auditor`, `sast-configuration`, `stride-analysis-patterns` |
| **AI/ML** | 10+ | `ml-engineer`, `rag-implementation`, `prompt-engineer` |
| **Database** | 8+ | `database-architect`, `postgresql`, `sql-optimization-patterns` |
| **SEO/Marketing** | 10+ | `seo-content-writer`, `seo-keyword-strategist` |
| **Business** | 8+ | `business-analyst`, `startup-analyst`, `sales-automator` |

## 🔄 Workflow Categories

| Category | Workflows |
|----------|-----------|
| **Scaffolding** | `python-scaffold`, `typescript-scaffold`, `rust-project` |
| **Development** | `feature-development`, `full-stack-feature`, `tdd-cycle` |
| **Review** | `ai-review`, `full-review`, `multi-agent-review` |
| **Security** | `security-hardening`, `security-sast`, `xss-scan` |
| **DevOps** | `workflow-automate`, `monitor-setup`, `incident-response` |
| **Documentation** | `doc-generate`, `code-explain`, `onboard` |

## 🔧 Customization

### Adding Custom Skills

Create a new skill in the `skills/` directory:

```
skills/my-custom-skill/
└── SKILL.md
```

With structure:
```yaml
---
name: my-custom-skill
description: Activates when [condition]. Focuses on [domain].
---

# My Custom Skill

Instructions for the agent...
```

### Adding Custom Workflows

Create a new workflow in `workflows/`:

```yaml
---
description: Short description for slash command help
---

# Workflow Name

## Phase 1: Requirements
...
```

## 📦 Upstream Sync

This repo is forked from [wshobson/agents](https://github.com/wshobson/agents). To sync with upstream:

```bash
git fetch upstream
git merge upstream/main
# Re-run conversion
powershell -File convert-to-antigravity.ps1
```

## 📄 License

MIT License - See [LICENSE](LICENSE)

---

**Maintained by**: [@judetelan](https://github.com/judetelan)  
**Upstream**: [wshobson/agents](https://github.com/wshobson/agents)

# 🚀 Antigravity Skills Collection

> **221 Skills** + **63 Workflows** for Google Antigravity

A comprehensive collection of production-ready skills and workflows for extending Google Antigravity's capabilities across development, DevOps, security, AI/ML, and more.

## 📦 Installation

### Global Installation (Recommended)

Clone directly into your global Antigravity skills directory:

```bash
# Clone as your global skills directory
git clone https://github.com/judetelan/agents-antigravity.git ~/.gemini/antigravity/skills-repo

# Copy skills to global location
cp -r ~/.gemini/antigravity/skills-repo/skills/* ~/.gemini/antigravity/skills/
cp -r ~/.gemini/antigravity/skills-repo/workflows/* ~/.gemini/antigravity/workflows/
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/judetelan/agents-antigravity.git "$HOME\.gemini\antigravity\skills-repo"

# Copy skills
Copy-Item -Recurse "$HOME\.gemini\antigravity\skills-repo\skills\*" "$HOME\.gemini\antigravity\skills\" -Force
Copy-Item -Recurse "$HOME\.gemini\antigravity\skills-repo\workflows\*" "$HOME\.gemini\antigravity\workflows\" -Force
```

### Workspace Installation

For project-specific use, copy to your workspace:

```bash
cp -r skills/* .agent/skills/
cp -r workflows/* .agent/workflows/
```

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
└── workflows/               # 63 Slash-Command Workflows
    ├── python-scaffold.md
    ├── full-stack-feature.md
    ├── security-hardening.md
    └── ... (60 more)
```

## ⚡ How It Works

### Automatic Skill Activation

Skills activate automatically based on your conversation:

```
User: "Build a FastAPI service with async database connections"

[Antigravity activates: async-python-patterns, fastapi-pro, api-design-principles]

Agent: "I'll help you build this using modern async patterns..."
```

### Workflow Invocation

Invoke workflows with slash commands:

```
User: "/python-scaffold"

Agent: "Let's create your Python project. What type...?"
```

## 📋 Skills by Category

| Category | Count | Examples |
|----------|-------|----------|
| **Python** | 12+ | `python-pro`, `async-python-patterns`, `fastapi-pro`, `django-pro` |
| **Backend/APIs** | 15+ | `backend-architect`, `api-design-principles`, `graphql-architect` |
| **JavaScript/TypeScript** | 10+ | `typescript-pro`, `nextjs-app-router-patterns`, `react-state-management` |
| **DevOps/Cloud** | 20+ | `kubernetes-architect`, `terraform-specialist`, `cloud-architect` |
| **Security** | 10+ | `security-auditor`, `sast-configuration`, `stride-analysis-patterns` |
| **AI/ML** | 10+ | `ml-engineer`, `rag-implementation`, `prompt-engineer`, `langchain-architecture` |
| **Database** | 8+ | `database-architect`, `postgresql`, `sql-optimization-patterns` |
| **SEO/Marketing** | 10+ | `seo-content-writer`, `seo-keyword-strategist` |
| **Business** | 8+ | `business-analyst`, `startup-analyst`, `sales-automator` |

## 🔧 Workflows by Category

| Category | Workflows |
|----------|-----------|
| **Scaffolding** | `/python-scaffold`, `/typescript-scaffold`, `/rust-project` |
| **Development** | `/feature-development`, `/full-stack-feature`, `/tdd-cycle` |
| **Code Review** | `/ai-review`, `/full-review`, `/multi-agent-review` |
| **Security** | `/security-hardening`, `/security-sast`, `/xss-scan` |
| **DevOps** | `/workflow-automate`, `/monitor-setup`, `/incident-response` |
| **Documentation** | `/doc-generate`, `/code-explain`, `/onboard` |

## 🎯 Popular Skills

### Development
- **`python-pro`** - Modern Python 3.12+ with uv, ruff, pydantic, FastAPI
- **`backend-architect`** - API design, microservices, distributed systems
- **`typescript-pro`** - Advanced TypeScript patterns and Node.js

### DevOps & Cloud
- **`kubernetes-architect`** - K8s architecture, deployments, Helm
- **`terraform-specialist`** - Infrastructure as code, multi-cloud
- **`github-actions-templates`** - CI/CD pipeline automation

### AI & ML
- **`rag-implementation`** - Retrieval-Augmented Generation systems
- **`prompt-engineer`** - Advanced prompt engineering patterns
- **`langchain-architecture`** - LLM application development

### Security
- **`security-auditor`** - Comprehensive security analysis
- **`sast-configuration`** - Static application security testing
- **`stripe-integration`** - Payment processing with Stripe

## 🔄 Creating Custom Skills

Add your own skills following the Antigravity format:

```yaml
# skills/my-skill/SKILL.md
---
name: my-skill
description: Activates when [condition]. Focuses on [domain].
---

# My Skill

Instructions for the agent...

## When to Use
- Scenario 1
- Scenario 2

## Best Practices
...
```

## 📄 License

MIT License - See [LICENSE](LICENSE)

---

**Based on**: [wshobson/agents](https://github.com/wshobson/agents) (Claude Code Plugins)  
**Converted for**: Google Antigravity  
**Maintained by**: [@judetelan](https://github.com/judetelan)

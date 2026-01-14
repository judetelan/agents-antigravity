# Convert Claude Code Plugins to Antigravity Skills Format
# This script restructures the repository for global Antigravity usage

$RepoRoot = $PSScriptRoot
$SkillsOutput = Join-Path $RepoRoot "skills"
$WorkflowsOutput = Join-Path $RepoRoot "workflows"
$PluginsDir = Join-Path $RepoRoot "plugins"

# Create output directories
New-Item -ItemType Directory -Path $SkillsOutput -Force | Out-Null
New-Item -ItemType Directory -Path $WorkflowsOutput -Force | Out-Null

Write-Host "=== Converting Claude Code Plugins to Antigravity Format ===" -ForegroundColor Cyan
Write-Host ""

# Track counts
$global:skillsConverted = 0
$global:agentsConverted = 0
$global:commandsConverted = 0

# --- PHASE 1: Direct copy of existing SKILL.md files ---
Write-Host "[Phase 1] Copying existing skills..." -ForegroundColor Yellow

$plugins = Get-ChildItem -Path $PluginsDir -Directory
foreach ($plugin in $plugins) {
    $pluginName = $plugin.Name
    $skillsDir = Join-Path $plugin.FullName "skills"
    
    if (Test-Path $skillsDir) {
        $skillFolders = Get-ChildItem -Path $skillsDir -Directory
        foreach ($skillFolder in $skillFolders) {
            $skillName = $skillFolder.Name
            $skillSource = Join-Path $skillFolder.FullName "SKILL.md"
            $skillDestDir = Join-Path $SkillsOutput $skillName
            $skillDest = Join-Path $skillDestDir "SKILL.md"
            
            if (Test-Path $skillSource) {
                New-Item -ItemType Directory -Path $skillDestDir -Force | Out-Null
                $content = Get-Content $skillSource -Raw
                $content = $content -replace "(?m)^model:.*`r?`n", ""
                Set-Content -Path $skillDest -Value $content -NoNewline
                Write-Host "  + $skillName" -ForegroundColor Green
                $global:skillsConverted++
            }
        }
    }
}

Write-Host ""
Write-Host "[Phase 2] Converting agents to skills..." -ForegroundColor Yellow

foreach ($plugin in $plugins) {
    $pluginName = $plugin.Name
    $agentsDir = Join-Path $plugin.FullName "agents"
    
    if (Test-Path $agentsDir) {
        $agentFiles = Get-ChildItem -Path $agentsDir -Filter "*.md"
        foreach ($agentFile in $agentFiles) {
            $agentName = $agentFile.BaseName
            $agentSource = $agentFile.FullName
            $skillDestDir = Join-Path $SkillsOutput $agentName
            $skillDest = Join-Path $skillDestDir "SKILL.md"
            
            if (-not (Test-Path $skillDestDir)) {
                New-Item -ItemType Directory -Path $skillDestDir -Force | Out-Null
                $content = Get-Content $agentSource -Raw
                $content = $content -replace "(?m)^model:.*`r?`n", ""
                Set-Content -Path $skillDest -Value $content -NoNewline
                Write-Host "  + $agentName (agent)" -ForegroundColor Cyan
                $global:agentsConverted++
            }
        }
    }
}

Write-Host ""
Write-Host "[Phase 3] Converting commands to workflows..." -ForegroundColor Yellow

foreach ($plugin in $plugins) {
    $pluginName = $plugin.Name
    $commandsDir = Join-Path $plugin.FullName "commands"
    
    if (Test-Path $commandsDir) {
        $commandFiles = Get-ChildItem -Path $commandsDir -Filter "*.md"
        foreach ($commandFile in $commandFiles) {
            $commandName = $commandFile.BaseName
            $commandSource = $commandFile.FullName
            $workflowDest = Join-Path $WorkflowsOutput "$commandName.md"
            
            $content = Get-Content $commandSource -Raw
            $content = $content -replace "(?m)^model:.*`r?`n", ""
            $content = $content -replace "(?m)^name:.*`r?`n", ""
            Set-Content -Path $workflowDest -Value $content -NoNewline
            Write-Host "  + $commandName (workflow)" -ForegroundColor Magenta
            $global:commandsConverted++
        }
    }
}

Write-Host ""
Write-Host "=== Conversion Complete ===" -ForegroundColor Cyan
Write-Host "  Skills copied:    $global:skillsConverted" -ForegroundColor Green
Write-Host "  Agents converted: $global:agentsConverted" -ForegroundColor Cyan
Write-Host "  Workflows created: $global:commandsConverted" -ForegroundColor Magenta
Write-Host ""
Write-Host "Output directories:"
Write-Host "  Skills:    $SkillsOutput"
Write-Host "  Workflows: $WorkflowsOutput"

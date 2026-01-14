# Validate all skills and workflows for Antigravity compatibility
# Reports any files with format issues

$ErrorCount = 0
$WarningCount = 0
$ValidCount = 0

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY FORMAT VALIDATION" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# --- VALIDATE SKILLS ---
Write-Host "[SKILLS] Validating 221 skills..." -ForegroundColor Yellow
Write-Host ""

$skills = Get-ChildItem -Path "skills" -Directory
foreach ($skill in $skills) {
    $skillMd = Join-Path $skill.FullName "SKILL.md"
    
    if (-not (Test-Path $skillMd)) {
        Write-Host "  ERROR: $($skill.Name) - Missing SKILL.md" -ForegroundColor Red
        $ErrorCount++
        continue
    }
    
    $content = Get-Content $skillMd -Raw
    $lines = $content -split "`n"
    
    # Check starts with ---
    $startsWithDelim = $lines[0].Trim() -eq "---"
    
    # Check has name:
    $hasName = $content -match "(?m)^name:\s*\S+"
    
    # Check has description:
    $hasDesc = $content -match "(?m)^description:\s*\S+"
    
    # Check has closing ---
    $hasClosingDelim = ($content -split "---").Count -ge 3
    
    # Check description length (should be < 1024)
    $descMatch = [regex]::Match($content, "(?ms)^description:\s*(.+?)(?=^[a-z]+:|^---)", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    $descLength = if ($descMatch.Success) { $descMatch.Groups[1].Value.Length } else { 0 }
    
    if (-not $startsWithDelim) {
        Write-Host "  ERROR: $($skill.Name) - Does not start with ---" -ForegroundColor Red
        $ErrorCount++
    }
    elseif (-not $hasName) {
        Write-Host "  ERROR: $($skill.Name) - Missing 'name:' field" -ForegroundColor Red
        $ErrorCount++
    }
    elseif (-not $hasDesc) {
        Write-Host "  ERROR: $($skill.Name) - Missing 'description:' field" -ForegroundColor Red
        $ErrorCount++
    }
    elseif (-not $hasClosingDelim) {
        Write-Host "  ERROR: $($skill.Name) - Missing closing --- delimiter" -ForegroundColor Red
        $ErrorCount++
    }
    elseif ($descLength -gt 1024) {
        Write-Host "  WARN:  $($skill.Name) - Description too long ($descLength chars)" -ForegroundColor Yellow
        $WarningCount++
        $ValidCount++
    }
    else {
        $ValidCount++
    }
}

Write-Host ""
Write-Host "Skills Summary: $ValidCount valid, $ErrorCount errors, $WarningCount warnings" -ForegroundColor $(if ($ErrorCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

# Reset for workflows
$SkillErrors = $ErrorCount
$SkillWarnings = $WarningCount
$SkillValid = $ValidCount
$ErrorCount = 0
$WarningCount = 0
$ValidCount = 0

# --- VALIDATE WORKFLOWS ---
Write-Host "[WORKFLOWS] Validating 63 workflows..." -ForegroundColor Yellow
Write-Host ""

$workflows = Get-ChildItem -Path "workflows" -Filter "*.md"
foreach ($workflow in $workflows) {
    $content = Get-Content $workflow.FullName -Raw
    $lines = $content -split "`n"
    
    # Check starts with ---
    $startsWithDelim = $lines[0].Trim() -eq "---"
    
    # Check has description:
    $hasDesc = $content -match "(?m)^description:\s*\S+"
    
    # Check has closing ---
    $closingIndex = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq "---") {
            $closingIndex = $i
            break
        }
    }
    $hasClosingDelim = $closingIndex -gt 0
    
    if (-not $startsWithDelim) {
        Write-Host "  ERROR: $($workflow.Name) - Does not start with ---" -ForegroundColor Red
        $ErrorCount++
    }
    elseif (-not $hasDesc) {
        Write-Host "  ERROR: $($workflow.Name) - Missing 'description:' field" -ForegroundColor Red
        $ErrorCount++
    }
    elseif (-not $hasClosingDelim) {
        Write-Host "  ERROR: $($workflow.Name) - Missing closing --- delimiter" -ForegroundColor Red
        $ErrorCount++
    }
    else {
        $ValidCount++
    }
}

Write-Host ""
Write-Host "Workflows Summary: $ValidCount valid, $ErrorCount errors, $WarningCount warnings" -ForegroundColor $(if ($ErrorCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

# --- FINAL REPORT ---
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  FINAL REPORT" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Skills:    $SkillValid / $($skills.Count) valid" -ForegroundColor $(if ($SkillErrors -eq 0) { "Green" } else { "Red" })
Write-Host "  Workflows: $ValidCount / $($workflows.Count) valid" -ForegroundColor $(if ($ErrorCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

$TotalErrors = $SkillErrors + $ErrorCount
if ($TotalErrors -eq 0) {
    Write-Host "  ALL FILES VALID" -ForegroundColor Green
    exit 0
} else {
    Write-Host "  $TotalErrors ERRORS FOUND - FIX REQUIRED" -ForegroundColor Red
    exit 1
}

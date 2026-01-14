# Comprehensive Skill & Workflow Testing
# Tests YAML parsing, field validation, and content structure

param(
    [switch]$Verbose
)

$TotalTests = 0
$PassedTests = 0
$FailedTests = 0
$Failures = @()

function Test-Skill {
    param([string]$Path, [string]$Name)
    
    $script:TotalTests++
    $errors = @()
    
    $content = Get-Content $Path -Raw -ErrorAction SilentlyContinue
    if (-not $content) {
        $errors += "Cannot read file"
        return $errors
    }
    
    # Test 1: Starts with ---
    if (-not $content.StartsWith("---")) {
        $errors += "Missing opening --- delimiter"
    }
    
    # Test 2: Has closing ---
    $parts = $content -split "---", 3
    if ($parts.Count -lt 3) {
        $errors += "Missing closing --- delimiter or malformed frontmatter"
    }
    
    # Test 3: Parse YAML frontmatter
    $frontmatter = ""
    if ($parts.Count -ge 2) {
        $frontmatter = $parts[1].Trim()
    }
    
    # Test 4: Has name field
    if (-not ($frontmatter -match "(?m)^name:\s*(\S.*)$")) {
        $errors += "Missing 'name:' field"
    } else {
        $extractedName = $Matches[1].Trim()
        # Test 4b: Name matches directory
        if ($extractedName -ne $Name) {
            $errors += "name '$extractedName' doesn't match directory '$Name'"
        }
    }
    
    # Test 5: Has description field
    if (-not ($frontmatter -match "(?m)^description:")) {
        $errors += "Missing 'description:' field"
    }
    
    # Test 6: Description has activation trigger words
    $triggerWords = @("when", "for", "use", "activates", "building", "creating", "implementing", "designing", "working")
    $descMatch = [regex]::Match($frontmatter, "(?ms)description:\s*(.+?)(?=$|^[a-z]+:)")
    if ($descMatch.Success) {
        $desc = $descMatch.Groups[1].Value.ToLower()
        $hasTrigger = $false
        foreach ($word in $triggerWords) {
            if ($desc -match $word) { $hasTrigger = $true; break }
        }
        if (-not $hasTrigger) {
            $errors += "Description may lack activation triggers"
        }
        
        # Test 7: Description length
        if ($desc.Length -gt 1024) {
            $errors += "Description too long ($($desc.Length) chars, max 1024)"
        }
        if ($desc.Length -lt 50) {
            $errors += "Description too short ($($desc.Length) chars)"
        }
    }
    
    # Test 8: Has content after frontmatter
    if ($parts.Count -ge 3) {
        $body = $parts[2].Trim()
        if ($body.Length -lt 100) {
            $errors += "Body content too short ($($body.Length) chars)"
        }
        
        # Test 9: Has at least one header
        if (-not ($body -match "(?m)^#")) {
            $errors += "Missing markdown headers in body"
        }
    }
    
    return $errors
}

function Test-Workflow {
    param([string]$Path, [string]$Name)
    
    $script:TotalTests++
    $errors = @()
    
    $content = Get-Content $Path -Raw -ErrorAction SilentlyContinue
    if (-not $content) {
        $errors += "Cannot read file"
        return $errors
    }
    
    # Test 1: Starts with ---
    if (-not $content.StartsWith("---")) {
        $errors += "Missing opening --- delimiter"
    }
    
    # Test 2: Has closing ---
    $parts = $content -split "---", 3
    if ($parts.Count -lt 3) {
        $errors += "Missing closing --- delimiter"
    }
    
    # Test 3: Has description field
    $frontmatter = ""
    if ($parts.Count -ge 2) {
        $frontmatter = $parts[1].Trim()
    }
    
    if (-not ($frontmatter -match "(?m)^description:")) {
        $errors += "Missing 'description:' field"
    }
    
    # Test 4: Has content after frontmatter
    if ($parts.Count -ge 3) {
        $body = $parts[2].Trim()
        if ($body.Length -lt 50) {
            $errors += "Body content too short"
        }
    }
    
    return $errors
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  COMPREHENSIVE SKILL & WORKFLOW TESTING" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Test Skills
Write-Host "[SKILLS] Testing 221 skills..." -ForegroundColor Yellow
$skillDirs = Get-ChildItem -Path "skills" -Directory
$skillPass = 0
$skillFail = 0

foreach ($dir in $skillDirs) {
    $skillPath = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillPath) {
        $errors = Test-Skill -Path $skillPath -Name $dir.Name
        if ($errors.Count -eq 0) {
            $skillPass++
            if ($Verbose) { Write-Host "  PASS: $($dir.Name)" -ForegroundColor Green }
        } else {
            $skillFail++
            Write-Host "  FAIL: $($dir.Name)" -ForegroundColor Red
            foreach ($err in $errors) {
                Write-Host "        - $err" -ForegroundColor Red
            }
            $Failures += @{Name=$dir.Name; Type="Skill"; Errors=$errors}
        }
    } else {
        $skillFail++
        Write-Host "  FAIL: $($dir.Name) - Missing SKILL.md" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Skills: $skillPass passed, $skillFail failed" -ForegroundColor $(if ($skillFail -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

# Test Workflows
Write-Host "[WORKFLOWS] Testing 63 workflows..." -ForegroundColor Yellow
$workflowFiles = Get-ChildItem -Path "workflows" -Filter "*.md"
$wfPass = 0
$wfFail = 0

foreach ($file in $workflowFiles) {
    $errors = Test-Workflow -Path $file.FullName -Name $file.BaseName
    if ($errors.Count -eq 0) {
        $wfPass++
        if ($Verbose) { Write-Host "  PASS: $($file.Name)" -ForegroundColor Green }
    } else {
        $wfFail++
        Write-Host "  FAIL: $($file.Name)" -ForegroundColor Red
        foreach ($err in $errors) {
            Write-Host "        - $err" -ForegroundColor Red
        }
        $Failures += @{Name=$file.Name; Type="Workflow"; Errors=$errors}
    }
}

Write-Host ""
Write-Host "Workflows: $wfPass passed, $wfFail failed" -ForegroundColor $(if ($wfFail -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

# Summary
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  TEST SUMMARY" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Skills:    $skillPass / $($skillDirs.Count) passed" -ForegroundColor $(if ($skillFail -eq 0) { "Green" } else { "Yellow" })
Write-Host "  Workflows: $wfPass / $($workflowFiles.Count) passed" -ForegroundColor $(if ($wfFail -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

$totalFail = $skillFail + $wfFail
if ($totalFail -eq 0) {
    Write-Host "  ALL TESTS PASSED" -ForegroundColor Green
    exit 0
} else {
    Write-Host "  $totalFail FAILURES - Review above" -ForegroundColor Red
    exit 1
}

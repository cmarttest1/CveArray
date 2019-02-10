### Build script called by Azure Pipelines
Write-Host "I'm the build script"

# Install Pester module if it is not already installed
if (-not (Get-Module -Name Pester -ListAvailable))
{
    Write-Host "Installing Pester"
    Install-Module -Name Pester -Scope CurrentUser -Force -Confirm:$false
}

function Add-Numbers($a, $b) {
    
    return $a + $b
}

$TestResults = Invoke-Pester -Path .\Tests -PassThru

$TestResults

if($TestResults.FailedCount -gt 0)
{
    Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    exit 1
}

# ==========================================
# WSL 2.7.11.0 - Installation Script
# ==========================================

$version = "2.7.11.0"

# 📁 Use script location (fallback included for interactive mode)
$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }

# 📦 MSI path relative to script root
$msiPath = Join-Path $basePath "wsl.2.7.11.0.x64.msi"

# 📄 MSI log file
$logPath = Join-Path $env:TEMP "wsl-$version-install.log"

# -------------------------
# Admin check
# -------------------------
$principal = New-Object Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "❌ Please run this script as Administrator." -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Installing WSL $version..." -ForegroundColor Cyan

# -------------------------
# Check pending reboot
# -------------------------
if (Test-Path "$env:WINDIR\winsxs\pending.xml") {
    Write-Host "⚠ A reboot is pending. Please restart Windows before running this script." -ForegroundColor Yellow
    exit 1
}

# -------------------------
# Validate MSI exists
# -------------------------
if (!(Test-Path $msiPath)) {
    Write-Host "❌ MSI not found at:" -ForegroundColor Red
    Write-Host $msiPath -ForegroundColor Yellow
    exit 1
}

# -------------------------
# Enable Windows features
# -------------------------
Write-Host "⚙ Enabling required Windows features..." -ForegroundColor Cyan

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart | Out-Null
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart | Out-Null

Write-Host "✔ Windows features enabled" -ForegroundColor Green

# -------------------------
# Install MSI silently
# -------------------------
Write-Host "📦 Installing WSL MSI..." -ForegroundColor Cyan

$arguments = "/i `"$msiPath`" /qn /norestart /L*v `"$logPath`""

$process = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -PassThru

# -------------------------
# Check result
# -------------------------
if ($process.ExitCode -ne 0) {
    Write-Host "❌ Installation failed. Exit code: $($process.ExitCode)" -ForegroundColor Red
    Write-Host "📄 Log file: $logPath" -ForegroundColor Yellow
    exit $process.ExitCode
}

Write-Host "✅ WSL $version installed successfully!" -ForegroundColor Green

# -------------------------
# Verify installation
# -------------------------
try {
    wsl --version
} catch {
    Write-Host "⚠ WSL installed but not immediately available (restart may be required)." -ForegroundColor Yellow
}

Write-Host "🔁 A restart may be required to complete setup." -ForegroundColor Magenta

# -----------------------------------
# Copy Configuration file .wslconfig
# -----------------------------------

# Define source and destination paths
$Source = Join-Path $PSScriptRoot ".wslconfig"
$Destination = "$env:USERPROFILE\.wslconfig"

# Check if the source file exists
if (Test-Path $Source) {
    # Copy the file, overwriting if necessary
    Copy-Item -Path $Source -Destination $Destination -Force
    Write-Host "Success: The .wslconfig file has been copied to '$Destination'." -ForegroundColor Green
} else {
    Write-Host "Error: The '.wslconfig' file could not be found in the script folder ($PSScriptRoot)." -ForegroundColor Red
}

# -------------------------
# Set ACLs
# -------------------------

# Automatically retrieve the currently logged-in username
$UserName = $env:USERNAME
$FilePath = "C:\Users\$UserName\.wslconfig"

# Check if the file exists
if (Test-Path $FilePath) {
    # Get the current ACL object of the file
    $Acl = Get-Acl $FilePath

    # Disable inheritance and copy existing rules to avoid losing system access
    $Acl.SetAccessRuleProtection($true, $true)

    # Define the rule to deny/restrict write access for the user
    $FileSystemRights = [System.Security.AccessControl.FileSystemRights]"Write, Modify, AppendData, WriteData, WriteExtendedAttributes, WriteAttributes"
    $AccessControlType = [System.Security.AccessControl.AccessControlType]::Deny
    
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($UserName, $FileSystemRights, $AccessControlType)
   
    # Add the deny rule to the ACL
    $Acl.AddAccessRule($AccessRule)

    # Apply the new permissions
    Set-Acl -Path $FilePath -AclObject $Acl
   
    Write-Host "The ACLs for the .wslconfig file have been successfully modified for the user $UserName." -ForegroundColor Green
} else {
    Write-Host "The .wslconfig file could not be found at location: $FilePath" -ForegroundColor Red
}
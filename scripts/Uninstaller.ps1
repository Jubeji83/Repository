# Ensure the script is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    exit
}

Write-Host "Searching for WSL MSI installations..." -ForegroundColor Cyan

# Find the Product Code for Windows Subsystem for Linux
$wslApp = Get-Package -Name "Windows Subsystem for Linux" -ErrorAction SilentlyContinue

if ($wslApp) {
    $productCode = $wslApp.FastPackageId
    Write-Host "Found: $($wslApp.Name) [$productCode]" -ForegroundColor Yellow
    Write-Host "Uninstalling..." -ForegroundColor White
    
    # Start the uninstallation process
    Start-Process "msiexec.exe" -ArgumentList "/x $productCode /qn /norestart" -Wait -NoNewWindow
    
    Write-Host "Uninstallation command sent successfully." -ForegroundColor Green
} else {
    Write-Host "WSL MSI package not found. It might already be uninstalled or was installed as a Windows Feature." -ForegroundColor Red
}

# Check for Administrator privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as an Administrator."
    Break
}

$features = @(
    "VirtualMachinePlatform",
    "Microsoft-Windows-Subsystem-Linux"
)

Write-Host "Starting the removal of Windows features..." -ForegroundColor Cyan

foreach ($feature in $features) {
    Write-Host "Attempting to disable: $feature" -ForegroundColor Yellow
    try {
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart -ErrorAction Stop
        Write-Host "Success: $feature has been disabled." -ForegroundColor Green
    } catch {
        Write-Host "Could not disable $feature (it may already be disabled or not installed)." -ForegroundColor Gray
    }
}

Write-Host "`Operation completed. A system restart is required to apply these changes." -ForegroundColor Green

Write-Host "`Process Complete." -ForegroundColor White
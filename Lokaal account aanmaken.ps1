# Start logging
$LogFilePath = "C:\ProgramData\Autopilot-Script-Log.txt"
Start-Transcript -Path $LogFilePath -Append

try {
    Write-Host "Script gestart op $(Get-Date)"

    # Definieer de gebruikersnaam
    $LocalUsername = "Gebruiker"

    # Controleer of de gebruiker al bestaat
    $UserExists = @(Get-WmiObject -Class Win32_UserAccount -Filter "Name='$LocalUsername'").Count -gt 0
    if (-not $UserExists) {
        Write-Host "Gebruiker $LocalUsername wordt aangemaakt."

        # Maak het lokale account aan zonder wachtwoord
        net user $LocalUsername /add
        Write-Host "Gebruiker $LocalUsername succesvol aangemaakt."
    } else {
        Write-Host "De gebruiker $LocalUsername bestaat al. Geen verdere actie nodig."
    }

    # Voeg de gebruiker toe aan de Administrators-groep
    net localgroup Administrators $LocalUsername /add
    Write-Host "Gebruiker $LocalUsername toegevoegd aan de Administrators-groep."

} catch {
    Write-Error "Er is een fout opgetreden: $_"
    Exit 1
} finally {
    Stop-Transcript
    Write-Host "Script voltooid op $(Get-Date)"
}

# Exit met een succesvolle status
Exit 0

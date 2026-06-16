{

    Write-Log -Message "Installation de Google Chrome en cours..."
    try{
            
        # Installer Google Chrome
        Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile "$env:TEMP\chrome_installer.exe"
        Start-Process -FilePath "$env:TEMP\chrome_installer.exe" -Args "/silent /install" -Verb RunAs -Wait
        Write-Log -Message "Google Chrome a été installé avec succès."
        }
    catch{
        Write-Log -Message "Erreur : Le telechargement de Google Chrome a echoue, verifiez votre connexion Internet, l'espace sur votre disque ou l'URL."
    }
        
}

{

    Write-Log -Message "Installation de Java en cours..."
    try{  
        # URL de téléchargement de Java
        $javaUrl = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=253195_f7fe8e644f724108bdb54139381e29a7"
        $javaInstallerPath = "$env:TEMP\java_installer.exe"

        # Télécharger l'installateur de Java
        Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstallerPath

        # Installer Java silencieusement
        Start-Process -FilePath $javaInstallerPath -Args "/s" -Verb RunAs -Wait
        Write-Log -Message "Java a ete installe avec succes."

    }
    catch{
        Write-Log -Message "Erreur : Le telechargement de Java a echoue, verifiez votre connexion Internet, l'espace sur votre disque ou l'URL."
    }

}

{

    Write-Log -Message "Installation de Adobe Reader en cours..."
    try{
        # Installer Adobe Reader
        Invoke-WebRequest -Uri "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/2001320074/AcroRdrDC2001320074_fr_FR.exe" -OutFile "$env:TEMP\adobe_reader_installer.exe"
        Start-Process -FilePath "$env:TEMP\adobe_reader_installer.exe" -Args "/sAll" -Verb RunAs -Wait
        Write-Log -Message "Adobe Reader a ete installe avec succes."

    }
    catch{
        Write-Log -Message "Erreur : Le telechargement de Adobe Reader a échoue, verifiez votre connexion Internet, l'espace sur votre disque ou l'URL."
    }

}

{

    $url    = "https://github.com/glpi-project/glpi-agent/releases/download/1.16/GLPI-Agent-1.16-x64.msi"
    $output = "$env:TEMP\GLPI-Agent-1.16-x64.msi"

    Write-Log "Installation de GLPI en cours"
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing

    if (Test-Path $output) {
        Write-Log "GLPI : installation silencieuse..."
        Start-Process "msiexec.exe" -ArgumentList "/i `"$output`" /quiet SERVER=$server" -Wait

        Write-Log "GLPI : configuration du registre..."
        $regPath = "HKLM:\SOFTWARE\GLPI-Agent"
        if (Test-Path $regPath) {
            Set-ItemProperty -Path $regPath -Name "server" -Value $server
            Set-ItemProperty -Path $regPath -Name "tag"    -Value $tag
        }
        Write-Log -Message "GLPI a ete installe avec succes."
    } else {
        Write-Log -Message "Echec du telechargement de GLPI."
    }

}

{

    # Lien officiel EU pour Splashtop SOS
    $url = "https://download.splashtop.com/sos/eu/SplashtopSOS.exe"

    # Chemins
    $downloadPath = "$env:TEMP\splashtop_sos_downloaded.exe"
    $finalPath = "$env:TEMP\SOS e-secure.exe"
    $defaultDesktop = "C:\Users\Default\Desktop"

    Write-Log -Message "Installation de Splashtop en cours..."
    try{
        # Télécharger le fichier
        Invoke-WebRequest -Uri $url -OutFile $downloadPath

        # Attendre 5 secondes avant de renommer
        Start-Sleep -Seconds 5

        # Supprimer le fichier final s'il existe déjà
        if (Test-Path $finalPath) {
            Remove-Item -Path $finalPath -Force
        }

        # Renommer le fichier
        Rename-Item -Path $downloadPath -NewName "SOS e-secure.exe"

        # Débloquer le fichier (équivalent clic droit > Propriétés > Débloquer)
        Unblock-File -Path $finalPath

        # Vérifier que le dossier Desktop du profil Default existe
        if (!(Test-Path $defaultDesktop)) {
            New-Item -ItemType Directory -Path $defaultDesktop -Force
        }

        # Copier dans le bureau du profil Default
        Copy-Item -Path $finalPath -Destination $defaultDesktop -Force
        Write-Log -Message "Splashtop a été installe avec succes."
    }
    catch{
        Write-Log -Message "Erreur : Le telechargement de Splashtop a échoue, vérifiez votre connexion Internet, l'espace sur votre disque ou l'URL."
    }
    
}      

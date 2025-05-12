@ECHO OFF

:: Définir le répertoire de travail
CD /D "%~dp0"

:: Vérifier si le lien symbolique existe déjà
IF EXIST "edk2\SmmInfect\" (
    ECHO Deleting existing symlink...
    rmdir "edk2\SmmInfect"
)

ECHO Creating symlink...

:: Référence : https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mklink
mklink /D "%~dp0/edk2/SmmInfect" "%~dp0"

PAUSE
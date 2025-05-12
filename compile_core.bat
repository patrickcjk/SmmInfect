@ECHO OFF

SET "COPY_OUTPUT=1"
SET "OUTPUT_PATH=%~dp0\edk2\Build\SmmInfect\RELEASE_VS2019\X64\SmmInfect\SmmInfect\SmmInfect\OUTPUT\SmmInfect.efi"
SET "EXPECTED_OUTPUT_PATH=%~dp0\Output\SmmInfect.efi"

@REM ##############################################################
@REM # You should not have to modify anything below this line
@REM #

SET "ORIGINAL_DIR=%CD%"
SET "WORKING_DIR=%~dp0"

CD /D %WORKING_DIR%

ECHO OUTPUT_PATH = %OUTPUT_PATH%

ECHO Please make sure to use Developer Command Prompt for VS 2022 to run this script.
ECHO Please make sure to install NASM at the root of C

IF NOT EXIST "edk2" (
    ECHO EDK2 not installed.
	GOTO END
)

IF NOT EXIST "edk2\SmmInfect\" (
    ECHO SmmInfect symlink not created. Please run create_symlink.bat as admin.
	GOTO END
)


ECHO Compiling SmmInfect...

ECHO Please don't forget to edit edk2/Conf/target.txt and set 
ECHO ACTIVE_PLATFORM to SmmInfect/SmmInfect.dsc
ECHO TARGET to RELEASE
ECHO TARGET_ARCH to X64



ECHO Seting up edk2
CALL edk2\edksetup.bat Rebuild
IF %errorlevel% neq 0 GOTO END
	
	
ECHO Building SmmInfect

CD /D edk2
call build
CD /D %WORKING_DIR%


if %COPY_OUTPUT% == 1 (
	ECHO Copying output file.
	::MKDIR Output
	XCOPY "%OUTPUT_PATH%" "%EXPECTED_OUTPUT_PATH%" /L /Y
)

:END
CD /D %ORIGINAL_DIR%
ECHO End of script.
PAUSE

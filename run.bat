@echo off
setlocal enabledelayedexpansion

:: Check if folder path was provided
if "%~1"=="" (
    echo Usage: %0 [Folder Path]
    exit /b 1
)

:: Save the current directory
set "ORIGINAL_DIR=%CD%"

:: Set the folder path from the argument
set "FOLDER_PATH=%~1"


:: Initialize a counter
set "counter=0"

:: Extract the first folder name from FOLDER_PATH
set "FIRST_FOLDER="
for %%i in (%FOLDER_PATH:\= %) do (
    set /a counter+=1
    if !counter! EQU 2 (
        set "FIRST_FOLDER=%%i"
    )
)

:: Change directory to the specified folder path
cd /d "%FOLDER_PATH%"

:: Set the name of your LaTeX file without the extension
set FILENAME=main

:: Compile the LaTeX document, outputting files to the build directory within the current folder
pdflatex -output-directory="build" "%FILENAME%.tex"

bibtex %FILENAME%
makeglossaries -d build %FILENAME%

pdflatex -output-directory="build" "%FILENAME%.tex"
pdflatex -output-directory="build" "%FILENAME%.tex"

:: Check if pdflatex succeeded
if %ERRORLEVEL% neq 0 (
    echo Compilation failed.
    exit /b %ERRORLEVEL%
)

:: Extract the name of the parent folder from the path provided in the argument
for %%i in (".\.") do set "PARENT_FOLDER=%%~nxi"

:: Rename PDF
rename ".\build\%FILENAME%.pdf" "%PARENT_FOLDER%.pdf"
if %ERRORLEVEL% neq 0 (
    echo Failed to rename PDF file.
    exit /b %ERRORLEVEL%
)

:: Save the current directory
set "OUTPUT_PDF_DIR=%ORIGINAL_DIR%\pdf_output\%FIRST_FOLDER%"
set "OUTPUT_PDF_FILE=%OUTPUT_PDF_DIR%\%PARENT_FOLDER%"


:: Check if the output folder exists, create it if it doesn't
if not exist "%OUTPUT_PDF_DIR%" (
    mkdir "%OUTPUT_PDF_DIR%"
) else (
    :: Check if a file with the same name already exists in output folder and deleting it so
    if exist "%OUTPUT_PDF_FILE%.pdf" del /Q "%OUTPUT_PDF_FILE%.pdf"
)

:: Move the PDF to the output folder
move /Y "build\%PARENT_FOLDER%.pdf" "%OUTPUT_PDF_DIR%"
if %ERRORLEVEL% neq 0 (
    echo Failed to move PDF file.
    exit /b %ERRORLEVEL%
)



:: Return to the original directory at the end
cd /d "%ORIGINAL_DIR%"

echo Compilation and extraction succeeded.
@echo off
setlocal

:: Check if folder path was provided
if "%~1"=="" (
    echo Usage: %0 [Folder Path]
    exit /b 1
)

:: Save the current directory
set "ORIGINAL_DIR=%CD%"

:: Set the folder path from the argument
set "FOLDER_PATH=%~1"

:: Change directory to the specified folder path
cd /d "%FOLDER_PATH%"

:: Set the name of your LaTeX file without the extension
set FILENAME=main

:: Compile the LaTeX document, outputting files to the build directory within the current folder
pdflatex -output-directory="build" "%FILENAME%.tex"
makeglossaries -d build main
pdflatex -output-directory="build" "%FILENAME%.tex"

:: Check if pdflatex succeeded
if %ERRORLEVEL% neq 0 (
    echo Compilation failed.
    exit /b %ERRORLEVEL%
)

:: Extract the name of the parent folder from the path provided in the argument
for %%i in (".\.") do set "PARENT_FOLDER=%%~nxi"

:: Delete every PDF file in the current directory
del /Q *.pdf

:: Move the PDF back to the specified folder and rename it to the parent folder's name
move /Y "build\%FILENAME%.pdf" ".\"
if %ERRORLEVEL% neq 0 (
    echo Failed to move PDF file.
    exit /b %ERRORLEVEL%
)

rename "%FILENAME%.pdf" "%PARENT_FOLDER%.pdf"
if %ERRORLEVEL% neq 0 (
    echo Failed to rename PDF file.
    exit /b %ERRORLEVEL%
)

:: Return to the original directory at the end
cd /d "%ORIGINAL_DIR%"

echo Compilation and extraction succeeded.
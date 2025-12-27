@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo           FathTTS - Nuitka Build Script
echo           VieNeu-TTS Compiled as C (not just imported)
echo ============================================================
echo.

REM Check Python version
python --version 2>&1 | findstr "3.12" >nul
if errorlevel 1 (
    echo [ERROR] Python 3.12 is required!
    echo Current Python:
    python --version
    pause
    exit /b 1
)
echo [OK] Python 3.12 found

REM Check eSpeak NG
espeak-ng --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] eSpeak NG is not installed!
    echo Please install from: https://github.com/espeak-ng/espeak-ng/releases
    pause
    exit /b 1
)
echo [OK] eSpeak NG found

REM Check Nuitka
pip show nuitka >nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing Nuitka...
    pip install nuitka ordered-set zstandard
)
echo [OK] Nuitka ready

REM Check required directories
if not exist "vieneu_tts_core" (
    echo [ERROR] vieneu_tts_core directory not found!
    echo Please run the restructuring script first.
    pause
    exit /b 1
)
if not exist "vieneu_utils" (
    echo [ERROR] vieneu_utils directory not found!
    echo Please run the restructuring script first.
    pause
    exit /b 1
)
echo [OK] VieNeu-TTS modules found

echo.
echo Starting Nuitka build...
echo This may take 10-30 minutes depending on your system.
echo.

REM Build with Nuitka
python -m nuitka ^
    --standalone ^
    --enable-plugin=tk-inter ^
    --enable-plugin=numpy ^
    --enable-plugin=anti-bloat ^
    --follow-imports ^
    --include-package=vieneu_tts_core ^
    --include-package=vieneu_utils ^
    --include-package=edge ^
    --include-package=auth_module ^
    --include-package=llama_cpp ^
    --include-package=phonemizer ^
    --include-package=phonemizer.backend ^
    --include-package=phonemizer.backend.espeak ^
    --include-package=neucodec ^
    --include-package=torch ^
    --include-package=torchaudio ^
    --include-package=librosa ^
    --include-package=soundfile ^
    --include-package=customtkinter ^
    --include-package=google.genai ^
    --include-package=requests ^
    --include-data-dir=vieneu_utils=vieneu_utils ^
    --include-data-files=vieneu_utils/phoneme_dict.json=vieneu_utils/phoneme_dict.json ^
    --include-data-files=vieneu_config.yaml=vieneu_config.yaml ^
    --include-data-dir=edge=edge ^
    --include-data-files=icon.ico=icon.ico ^
    --nofollow-import-to=lmdeploy ^
    --nofollow-import-to=triton ^
    --nofollow-import-to=triton_windows ^
    --nofollow-import-to=cuda ^
    --windows-disable-console ^
    --windows-icon-from-ico=icon.ico ^
    --company-name="FathTTS" ^
    --product-name="FathTTS Studio" ^
    --output-dir=dist ^
    main.py

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo ============================================================
echo                    BUILD SUCCESSFUL!
echo ============================================================
echo.
echo Output directory: dist\main.dist\
echo.
echo Post-build steps:
echo 1. Copy ffmpeg.exe to dist\main.dist\
echo 2. Copy VieNeu-TTS\sample\ to dist\main.dist\VieNeu-TTS\sample\ (for voice samples)
echo 3. Rename main.exe to FathTTS.exe if needed
echo.

REM Copy additional files
echo Copying additional files...
if exist "ffmpeg.exe" (
    copy "ffmpeg.exe" "dist\main.dist\" >nul
    echo [OK] Copied ffmpeg.exe
)

if exist "VieNeu-TTS\sample" (
    xcopy /E /I /Y "VieNeu-TTS\sample" "dist\main.dist\VieNeu-TTS\sample" >nul
    echo [OK] Copied voice samples
)

echo.
echo Done! Your application is ready at: dist\main.dist\main.exe
pause

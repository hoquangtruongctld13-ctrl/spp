#!/bin/bash
# ============================================================
#           FathTTS - Nuitka Build Script (Linux/macOS)
#           VieNeu-TTS Compiled as C (not just imported)
# ============================================================

set -e

echo "============================================================"
echo "          FathTTS - Nuitka Build Script"
echo "          VieNeu-TTS Compiled as C (not just imported)"
echo "============================================================"
echo ""

# Check Python version
if ! python3.12 --version &> /dev/null; then
    echo "[ERROR] Python 3.12 is required!"
    echo "Current Python:"
    python3 --version || echo "Python not found"
    exit 1
fi
echo "[OK] Python 3.12 found"

# Check eSpeak NG
if ! espeak-ng --version &> /dev/null; then
    echo "[ERROR] eSpeak NG is not installed!"
    echo "Install with:"
    echo "  Ubuntu/Debian: sudo apt install espeak-ng"
    echo "  macOS: brew install espeak-ng"
    exit 1
fi
echo "[OK] eSpeak NG found"

# Check Nuitka
if ! pip show nuitka &> /dev/null; then
    echo "[INFO] Installing Nuitka..."
    pip install nuitka ordered-set zstandard
fi
echo "[OK] Nuitka ready"

# Check required directories
if [ ! -d "vieneu_tts_core" ]; then
    echo "[ERROR] vieneu_tts_core directory not found!"
    echo "Please run the restructuring script first."
    exit 1
fi
if [ ! -d "vieneu_utils" ]; then
    echo "[ERROR] vieneu_utils directory not found!"
    echo "Please run the restructuring script first."
    exit 1
fi
echo "[OK] VieNeu-TTS modules found"

echo ""
echo "Starting Nuitka build..."
echo "This may take 10-30 minutes depending on your system."
echo ""

# Build with Nuitka
python3 -m nuitka \
    --standalone \
    --enable-plugin=tk-inter \
    --enable-plugin=numpy \
    --enable-plugin=anti-bloat \
    --follow-imports \
    --include-package=vieneu_tts_core \
    --include-package=vieneu_utils \
    --include-package=edge \
    --include-package=auth_module \
    --include-package=llama_cpp \
    --include-package=phonemizer \
    --include-package=phonemizer.backend \
    --include-package=phonemizer.backend.espeak \
    --include-package=neucodec \
    --include-package=torch \
    --include-package=torchaudio \
    --include-package=librosa \
    --include-package=soundfile \
    --include-package=customtkinter \
    --include-package=google.genai \
    --include-package=requests \
    --include-data-dir=vieneu_utils=vieneu_utils \
    --include-data-files=vieneu_utils/phoneme_dict.json=vieneu_utils/phoneme_dict.json \
    --include-data-files=vieneu_config.yaml=vieneu_config.yaml \
    --include-data-dir=edge=edge \
    --include-data-files=icon.ico=icon.ico \
    --nofollow-import-to=lmdeploy \
    --nofollow-import-to=triton \
    --nofollow-import-to=cuda \
    --output-dir=dist \
    main.py

echo ""
echo "============================================================"
echo "                   BUILD SUCCESSFUL!"
echo "============================================================"
echo ""
echo "Output directory: dist/main.dist/"
echo ""
echo "Post-build steps:"
echo "1. Copy ffmpeg to dist/main.dist/"
echo "2. Copy VieNeu-TTS/sample/ to dist/main.dist/VieNeu-TTS/sample/ (for voice samples)"
echo ""

# Copy additional files
echo "Copying additional files..."
if [ -f "ffmpeg" ]; then
    cp "ffmpeg" "dist/main.dist/"
    echo "[OK] Copied ffmpeg"
fi

if [ -d "VieNeu-TTS/sample" ]; then
    mkdir -p "dist/main.dist/VieNeu-TTS"
    cp -r "VieNeu-TTS/sample" "dist/main.dist/VieNeu-TTS/"
    echo "[OK] Copied voice samples"
fi

echo ""
echo "Done! Your application is ready at: dist/main.dist/main.bin"

"""
VieNeu-TTS Utilities Module

This module contains utility functions for VieNeu-TTS:
- core_utils: Text chunking utilities
- normalize_text: Vietnamese text normalization for TTS
- phonemize_text: Text-to-phoneme conversion with dictionary
"""

from .core_utils import split_text_into_chunks
from .normalize_text import VietnameseTTSNormalizer
from .phonemize_text import phonemize_text, phonemize_with_dict

__all__ = [
    "split_text_into_chunks",
    "VietnameseTTSNormalizer",
    "phonemize_text",
    "phonemize_with_dict",
]

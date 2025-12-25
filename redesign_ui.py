#!/usr/bin/env python3
"""
Script to remove emojis and modernize UI elements in main.py
"""

import re

def remove_emojis_from_file(filepath):
    """Remove emojis from button text and labels"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Patterns to replace
    replacements = [
        # Buttons with common emojis
        (r'text="🎙️ TẠO AUDIO', 'text="CREATE AUDIO'),
        (r'text="🎙️ TẠO AUDIO VỚI GIỌNG ĐÃ CLONE', 'text="CREATE WITH CLONED VOICE'),
        (r'text="▶ PHÁT', 'text="PLAY'),
        (r'text="⏹ DỪNG', 'text="STOP'),
        (r'text="💾 LƯU FILE', 'text="SAVE FILE'),
        (r'text="💾 LƯU GIỌNG VÀO DANH SÁCH', 'text="SAVE VOICE'),
        (r'text="🔧 Mã hóa giọng mẫu', 'text="Encode Voice'),
        (r'text="🚀 XỬ LÝ FILE/THƯ MỤC', 'text="PROCESS FILES'),
        (r'text="📁 Chọn', 'text="Browse'),
        (r'text="📁 Thư mục', 'text="Folder'),
        (r'text="📂', 'text="...'),
        (r'text="⚡ Streaming', 'text="Streaming'),
        (r'text="▶ Nghe thử giọng mẫu', 'text="Preview Voice'),
        
        # Labels with emojis
        (r'text="📝 NHẬP VĂN BẢN CẦN ĐỌC', 'text="TEXT INPUT'),
        (r'text="📝 TẠO VOICE TỪ FILE', 'text="CREATE FROM FILE'),
        (r'text="📁 XỬ LÝ FILE HÀNG LOẠT', 'text="BATCH PROCESSING'),
        (r'text="⚙️ CẤU HÌNH MODEL', 'text="MODEL CONFIGURATION'),
        (r'text="📝 Nội dung lời thoại mẫu:', 'text="Reference Text:'),
        (r'text="💾 Lưu giọng với tên:', 'text="Voice Name:'),
        (r'text="📝 Trình tạo kịch bản', 'text="Script Builder'),
        (r'text="⚙️ Cài đặt giọng đọc', 'text="Voice Settings'),
    ]
    
    for pattern, replacement in replacements:
        content = re.sub(pattern, replacement, content)
    
    # Remove remaining single emojis at start of text
    content = re.sub(r'text="[🎵🎙️💾▶⏹⚙️🚀📝✅❌📁🔧⚡💡📄📂🇻🇳] ', 'text="', content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✓ Emojis removed from {filepath}")

if __name__ == '__main__':
    remove_emojis_from_file('main.py')

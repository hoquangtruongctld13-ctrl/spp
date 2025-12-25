#!/usr/bin/env python3
"""
Update frame colors to modern professional palette
"""

def update_frame_colors(filepath):
    """Update frame colors to modern professional palette"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Define frame color replacements
    replacements = [
        # Dark frames -> Modern dark blue-grey
        ('fg_color="#1a2332"', 'fg_color="#1e2a3a"'),
        ('fg_color="#0d1117"', 'fg_color="#1a2530"'),
        ('fg_color="#111827"', 'fg_color="#1e2a3a"'),
        ('fg_color="#1f2937"', 'fg_color="#242e3d"'),
        ('fg_color="#1e293b"', 'fg_color="#1e2a3a"'),
        ('fg_color="#334155"', 'fg_color="#2a3846"'),
        
        # Darker elements
        ('fg_color="#444"', 'fg_color="#2a3846"'),
    ]
    
    for old, new in replacements:
        content = content.replace(old, new)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✓ Frame colors updated in {filepath}")

if __name__ == '__main__':
    update_frame_colors('main.py')

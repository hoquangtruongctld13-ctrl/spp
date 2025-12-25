#!/usr/bin/env python3
"""
Update button colors to professional palette
"""

import re

def update_button_colors(filepath):
    """Update button colors to modern professional palette"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Define color replacements for a professional palette
    replacements = [
        # Green buttons (success actions) -> Professional teal/green
        ('fg_color="#22c55e"', 'fg_color="#4a7c59"'),
        ('hover_color="#16a34a"', 'hover_color="#3d6b4a"'),
        
        # Blue buttons (info/play actions) -> Professional blue
        ('fg_color="#3b82f6"', 'fg_color="#5a7a9d"'),
        
        # Red buttons (stop/delete actions) -> Professional red/brown
        ('fg_color="#ef4444"', 'fg_color="#8d5a4a"'),
        ('fg_color="#dc2626"', 'fg_color="#8d4a2d"'),
        
        # Purple buttons -> Professional purple
        ('fg_color="#6366f1"', 'fg_color="#6a5a8d"'),
        ('fg_color="#7c3aed"', 'fg_color="#5a4a8d"'),
        
        # Orange buttons -> Professional orange/amber
        ('fg_color="#f59e0b"', 'fg_color="#8d7a4a"'),
        ('hover_color="#d97706"', 'hover_color="#7a6a3d"'),
        
        # Add corner_radius to buttons that don't have it
        ('command=self._', 'corner_radius=8, command=self._'),
    ]
    
    for old, new in replacements:
        content = content.replace(old, new)
    
    # Remove duplicate corner_radius if it was added twice
    content = re.sub(r'corner_radius=8,\s*corner_radius=8,', 'corner_radius=8,', content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✓ Button colors updated in {filepath}")

if __name__ == '__main__':
    update_button_colors('main.py')

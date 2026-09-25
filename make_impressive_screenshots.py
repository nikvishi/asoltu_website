from PIL import Image, ImageDraw, ImageFilter
import os

def create_mac_window(img_path, output_path, bg_color_start, bg_color_end):
    if not os.path.exists(img_path):
        print(f"File not found: {img_path}")
        return
        
    original = Image.open(img_path).convert("RGBA")
    
    # Scale down a bit if too large
    max_w = 1200
    if original.width > max_w:
        ratio = max_w / float(original.width)
        original = original.resize((max_w, int(original.height * ratio)), Image.Resampling.LANCZOS)
        
    w, h = original.size
    
    # Rounded corners for the screenshot
    radius = 16
    mask = Image.new('L', (w, h), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle((0, 0, w, h), radius=radius, fill=255)
    
    rounded_img = Image.new('RGBA', (w, h))
    rounded_img.paste(original, (0, 0), mask=mask)
    
    # Add Mac Title bar
    title_bar_height = 36
    title_bar = Image.new('RGBA', (w, title_bar_height), (45, 45, 45, 255))
    tb_mask = Image.new('L', (w, title_bar_height), 0)
    tb_draw = ImageDraw.Draw(tb_mask)
    tb_draw.rounded_rectangle((0, 0, w, title_bar_height * 2), radius=radius, fill=255) # Only round top
    
    final_title_bar = Image.new('RGBA', (w, title_bar_height))
    final_title_bar.paste(title_bar, (0, 0), mask=tb_mask)
    
    # Add mac buttons
    tb_draw = ImageDraw.Draw(final_title_bar)
    tb_draw.ellipse((16, 12, 28, 24), fill=(255, 95, 86, 255))  # Red
    tb_draw.ellipse((36, 12, 48, 24), fill=(255, 189, 46, 255)) # Yellow
    tb_draw.ellipse((56, 12, 68, 24), fill=(39, 201, 63, 255))  # Green
    
    # Combine title bar and screenshot
    window = Image.new('RGBA', (w, h + title_bar_height))
    window.paste(final_title_bar, (0, 0))
    window.paste(rounded_img, (0, title_bar_height))
    
    # Create gradient background
    padding = 120
    bg_w = w + padding * 2
    bg_h = h + title_bar_height + padding * 2
    bg = Image.new('RGBA', (bg_w, bg_h))
    
    # Draw linear gradient
    r1, g1, b1 = bg_color_start
    r2, g2, b2 = bg_color_end
    for y in range(bg_h):
        r = int(r1 + (r2 - r1) * y / bg_h)
        g = int(g1 + (g2 - g1) * y / bg_h)
        b = int(b1 + (b2 - b1) * y / bg_h)
        ImageDraw.Draw(bg).line([(0, y), (bg_w, y)], fill=(r, g, b, 255))
        
    # Draw shadow
    shadow_img = Image.new('RGBA', (bg_w, bg_h), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow_img)
    shadow_offset = 30
    shadow_draw.rounded_rectangle(
        (padding, padding + shadow_offset, padding + w, padding + h + title_bar_height + shadow_offset),
        radius=radius,
        fill=(0, 0, 0, 100)
    )
    shadow_img = shadow_img.filter(ImageFilter.GaussianBlur(40))
    
    # Paste shadow and window
    bg = Image.alpha_composite(bg, shadow_img)
    bg.paste(window, (padding, padding), window)
    
    # Save optimized
    bg = bg.convert("RGB")
    bg.save(output_path, "JPEG", quality=85)
    print(f"Created impressive screenshot: {output_path}")

# Blue to Purple gradient for DataHop
create_mac_window(
    "assets/images/products/datahop_screenshot.png",
    "assets/images/products/datahop_impressive.jpg",
    (37, 99, 235), (124, 58, 237)
)

# Dark slate to Emerald gradient for Download Manager
create_mac_window(
    "assets/images/products/adm_screenshot.png",
    "assets/images/products/adm_impressive.jpg",
    (15, 23, 42), (16, 185, 129)
)


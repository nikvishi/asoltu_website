import Quartz
import Quartz.CoreGraphics as CG
import CoreFoundation
from PIL import Image
import os
import time
import subprocess

def capture_window(app_name, output_path):
    # Launch app
    subprocess.run(["open", "-a", app_name])
    time.sleep(3) # Wait for it to open

    # Get window list
    window_list = CG.CGWindowListCopyWindowInfo(CG.kCGWindowListOptionOnScreenOnly | CG.kCGWindowListExcludeDesktopElements, CG.kCGNullWindowID)
    
    for window in window_list:
        owner = window.get(CG.kCGWindowOwnerName, '')
        if app_name.lower() in str(owner).lower():
            # Found the window
            window_id = window[CG.kCGWindowNumber]
            bounds = window[CG.kCGWindowBounds]
            width = int(bounds['Width'])
            height = int(bounds['Height'])
            
            if width < 100 or height < 100:
                continue # Skip small invisible windows
                
            print(f"Found {app_name} window {width}x{height}")
            
            # Capture
            image = CG.CGWindowListCreateImage(
                CG.CGRectNull,
                CG.kCGWindowListOptionIncludingWindow,
                window_id,
                CG.kCGWindowImageBoundsIgnoreFraming
            )
            
            if image:
                # Convert CGImage to PNG using sips or python
                temp_path = f"/tmp/{app_name.replace(' ', '_')}.png"
                url = CoreFoundation.CFURLCreateWithFileSystemPath(None, temp_path, CoreFoundation.kCFURLPOSIXPathStyle, False)
                dest = Quartz.CGImageDestinationCreateWithURL(url, 'public.png', 1, None)
                Quartz.CGImageDestinationAddImage(dest, image, None)
                Quartz.CGImageDestinationFinalize(dest)
                
                # Move to final output
                os.rename(temp_path, output_path)
                print(f"Saved {output_path}")
                
                # Close app
                subprocess.run(["osascript", "-e", f'quit app "{app_name}"'])
                return True
                
    print(f"Could not find window for {app_name}")
    subprocess.run(["osascript", "-e", f'quit app "{app_name}"'])
    return False

capture_window("DataHop", "assets/images/products/datahop_screenshot.png")
capture_window("Asoltu Download Manager", "assets/images/products/adm_screenshot.png")

import re

with open('web/index.html', 'r') as f:
    content = f.read()

new_styles = """
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background: #0D1B5E;
    }
    .asoltu-boot {
      min-height: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: #ffffff;
    }
    
    .spinner-container {
      position: relative;
      width: 120px;
      height: 120px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 30px;
    }

    .pulse-ring {
      position: absolute;
      width: 100%;
      height: 100%;
      border-radius: 50%;
      border: 2px solid rgba(212, 175, 55, 0.6);
      animation: pulseAnim 2s cubic-bezier(0.4, 0, 0.2, 1) infinite;
    }

    .pulse-ring:nth-child(2) {
      animation-delay: 1s;
    }

    .logo-center {
      width: 72px;
      height: 72px;
      background: linear-gradient(135deg, #1A2C80 0%, #0D1B5E 100%);
      border-radius: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 900;
      font-size: 32px;
      color: #D4AF37;
      border: 1px solid rgba(255,255,255,0.1);
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
      z-index: 10;
      letter-spacing: -1px;
    }

    @keyframes pulseAnim {
      0% {
        transform: scale(0.6);
        opacity: 1;
      }
      100% {
        transform: scale(1.5);
        opacity: 0;
      }
    }

    .brand-text {
      font-size: 24px;
      font-weight: 800;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      background: linear-gradient(90deg, #FFFFFF, #D4AF37);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 12px;
    }

    .loading-bar-container {
      width: 200px;
      height: 4px;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 4px;
      overflow: hidden;
      position: relative;
    }

    .loading-bar {
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      width: 50%;
      background: #D4AF37;
      border-radius: 4px;
      animation: loadingAnim 1.5s ease-in-out infinite alternate;
    }

    @keyframes loadingAnim {
      0% {
        left: -50%;
      }
      100% {
        left: 100%;
      }
    }

    .skip-link {
      position: absolute;
      left: -9999px;
      top: 0;
      z-index: 100000;
      padding: 12px 16px;
      background: #1E5EFF;
      color: #fff;
      font-family: system-ui, sans-serif;
      font-weight: 600;
      text-decoration: none;
    }
    .skip-link:focus {
      left: 12px;
      top: 12px;
    }
  </style>
"""

new_body = """
  <div class="asoltu-boot" id="asoltu-boot" role="status" aria-live="polite" aria-label="Loading ASOLTU website">
    <div class="spinner-container">
      <div class="pulse-ring"></div>
      <div class="pulse-ring"></div>
      <div class="logo-center">A</div>
    </div>
    <div class="brand-text">ASOLTU</div>
    <div class="loading-bar-container">
      <div class="loading-bar"></div>
    </div>
  </div>
"""

# Replace styles
content = re.sub(r'<style>.*?</style>', new_styles, content, flags=re.DOTALL)
# Replace body boot div
content = re.sub(r'<div class="asoltu-boot".*?</div>\s*</div>', new_body, content, flags=re.DOTALL)

with open('web/index.html', 'w') as f:
    f.write(content)

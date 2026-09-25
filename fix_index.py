import re
with open('web/index.html', 'r') as f:
    code = f.read()

unregister_script = """
  <main id="main">
    <script>
      // UNREGISTER ANY OLD SERVICE WORKERS to prevent aggressive caching
      if ('serviceWorker' in navigator) {
        navigator.serviceWorker.getRegistrations().then(function(registrations) {
          for(let registration of registrations) {
            registration.unregister();
            console.log('Unregistered old service worker.');
          }
        });
      }
      
      window.addEventListener('flutter-first-frame', function () {
        var el = document.getElementById('asoltu-boot');
        if (el && el.parentNode) el.parentNode.removeChild(el);
      });
    </script>
"""

code = code.replace("""
  <main id="main">
    <script>
      window.addEventListener('flutter-first-frame', function () {
""", unregister_script.strip() + "\n")

with open('web/index.html', 'w') as f:
    f.write(code)

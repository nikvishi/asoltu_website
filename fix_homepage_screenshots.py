with open('lib/features/home/presentation/home_page.dart', 'r') as f:
    code = f.read()

import re

# We will define a new _AsoltuAppVisual class
new_class = """
class _AsoltuAppVisual extends StatelessWidget {
  const _AsoltuAppVisual();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -40,
            child: Transform.rotate(
              angle: -0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/products/asoltu_app_1.jpg', width: 140, height: 280, fit: BoxFit.cover),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -5, end: 5, duration: 3.seconds),
          Positioned(
            child: Transform.scale(
              scale: 1.1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/products/asoltu_app_2.jpg', width: 150, height: 300, fit: BoxFit.cover),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 5, end: -5, duration: 4.seconds),
          Positioned(
            right: -40,
            child: Transform.rotate(
              angle: 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/products/asoltu_app_3.jpg', width: 140, height: 280, fit: BoxFit.cover),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -5, end: 5, duration: 3.5.seconds),
        ],
      )
    );
  }
}
"""

if "_AsoltuAppVisual" not in code:
    code += new_class

# Now we need to update the _BentoCard for Asoltu to use this customVisual
# The Asoltu BentoCard looks like:
# _BentoCard(
#   title: 'Asoltu - The Learning App',
#   description: 'Students desh ke sabhi exams ki practise ab ek jahgah ek app me kar sakte hai. Sabse secure live test system hai Asoltu ke paas.',
#   icon: Icons.menu_book_rounded,
#   width: isMobile ? double.infinity : 784,
#   height: 420,
#   isApp: true,
#   onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.absolutetutorials.app')),
# ),

code = code.replace("""_BentoCard(
                  title: 'Asoltu - The Learning App',
                  description: 'Students desh ke sabhi exams ki practise ab ek jahgah ek app me kar sakte hai. Sabse secure live test system hai Asoltu ke paas.',
                  icon: Icons.menu_book_rounded,
                  width: isMobile ? double.infinity : 784,
                  height: 420,
                  isApp: true,
                  onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.absolutetutorials.app')),
                ),""", """_BentoCard(
                  title: 'Asoltu - The Learning App',
                  description: 'Students desh ke sabhi exams ki practise ab ek jahgah ek app me kar sakte hai. Sabse secure live test system hai Asoltu ke paas.',
                  icon: Icons.menu_book_rounded,
                  customVisual: const _AsoltuAppVisual(),
                  width: isMobile ? double.infinity : 784,
                  height: 520, // Increased height to accommodate the screenshots and the app buttons
                  isApp: true,
                  onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.absolutetutorials.app')),
                ),""")

with open('lib/features/home/presentation/home_page.dart', 'w') as f:
    f.write(code)

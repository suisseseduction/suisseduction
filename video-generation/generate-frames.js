const path = require('path');
const fs = require('fs');

(async () => {
  const puppeteer = await import('puppeteer');

  // Create frames directory if it doesn't exist
  const framesDir = path.join(__dirname, 'frames');
  if (!fs.existsSync(framesDir)) {
    fs.mkdirSync(framesDir, { recursive: true });
  }

  // Launch browser
  const browser = await puppeteer.default.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });
  const page = await browser.newPage();

  // Set viewport
  await page.setViewport({ width: 1200, height: 800 });

  // Load the page (French version)
  await page.goto('file://' + path.join(__dirname, '..', 'index.html'), {
    waitUntil: 'networkidle0',
  });

  // Wait for fonts to load (optional but good practice)
  await page.evaluateHandle('document.fonts.ready');

  // Define sections to capture
  const sections = [
    { id: 'page-top', name: 'header' },
    { id: 'about', name: 'about' },
    { id: 'services', name: 'services' },
    { id: 'prices', name: 'prices' },
    { id: 'contact', name: 'contact' },
  ];

  // Capture each section
  for (let i = 0; i < sections.length; i++) {
    const section = sections[i];
    try {
      // Scroll to section
      await page.evaluate((id) => {
        const element = document.getElementById(id);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      }, section.id);

      // Wait for scroll and any animations
      await new Promise((resolve) => setTimeout(resolve, 1000));

      // Take screenshot
      const screenshotPath = path.join(framesDir, `${section.name}.png`);
      await page.screenshot({ path: screenshotPath });
      console.log(`Captured ${section.name} section`);
    } catch (error) {
      console.error(`Error capturing ${section.name}:`, error);
    }
  }

  // Also capture the full page for a title slide
  try {
    await page.evaluate(() => {
      window.scrollTo(0, 0);
    });
    await new Promise((resolve) => setTimeout(resolve, 500));
    const titlePath = path.join(framesDir, 'title.png');
    await page.screenshot({ path: titlePath, fullPage: true });
    console.log('Captured title slide');
  } catch (error) {
    console.error('Error capturing title slide:', error);
  }

  await browser.close();
  console.log('All frames generated successfully!');
  console.log(`Frames saved to: ${framesDir}`);
  console.log('\nTo create video with FFmpeg, run:');
  console.log(
    `ffmpeg -framerate 1/5 -i ${framesDir}/%d.png -c:v libx264 -pix_fmt yuv420p -vf "scale=1200:800:force_original_aspect_ratio=decrease,pad=1200:800:(ow-iw)/2:(oh-ih)/2" output.mp4`,
  );
  console.log('\nOr for a simpler slideshow:');
  console.log(
    `ffmpeg -framerate 1/5 -i ${framesDir}/title.png -i ${framesDir}/header.png -i ${framesDir}/about.png -i ${framesDir}/services.png -i ${framesDir}/prices.png -i ${framesDir}/contact.png -c:v libx264 -pix_fmt yuv420p -vf "fade=t=in:st=0:d=1,fade=t=out:st=4:d=1" output.mp4`,
  );
})();

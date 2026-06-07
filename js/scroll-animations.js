/**
 * scroll-animations.js
 * Elegant scroll-triggered animations via Intersection Observer.
 *
 * Elements with `data-animate="type"` receive `.is-visible` when they
 * scroll into view. The observer fires once per element (unobserves after
 * triggering) so animations only play on first reveal.
 */
(function () {
  'use strict';

  // Respect user's motion preferences
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  var els = document.querySelectorAll('[data-animate]');
  if (!els.length) return;

  var observer = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    },
    {
      threshold: 0.15,
      rootMargin: '0px 0px -40px 0px',
    }
  );

  for (var i = 0; i < els.length; i++) {
    observer.observe(els[i]);
  }
})();

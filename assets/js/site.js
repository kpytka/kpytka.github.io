/*
	kpytka.eu — site behaviour (no dependencies)
	- header hairline on scroll
	- current-section highlighting in the navigation
	- reveal-on-scroll for section content
	- the name typing animation
	- BibTeX dialog with copy-to-clipboard
*/

(function () {
	'use strict';

	var d = document;
	var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

	/* ---------- Header ---------- */

	var header = d.querySelector('.site-header');

	function onScroll() {
		if (header) header.classList.toggle('is-scrolled', window.scrollY > 4);
	}

	window.addEventListener('scroll', onScroll, { passive: true });
	onScroll();

	/* ---------- Navigation ---------- */

	var nav = d.querySelector('.site-nav');
	var navLinks = nav ? Array.prototype.slice.call(nav.querySelectorAll('a[href^="#"]')) : [];

	function checkNavOverflow() {
		if (!nav) return;
		nav.classList.toggle('is-overflowing', nav.scrollWidth > nav.clientWidth + 1);
	}

	window.addEventListener('resize', checkNavOverflow);
	checkNavOverflow();

	function setCurrent(id) {
		navLinks.forEach(function (link) {
			if (link.getAttribute('href') === '#' + id) {
				link.setAttribute('aria-current', 'true');
			} else {
				link.removeAttribute('aria-current');
			}
		});
	}

	var sections = navLinks
		.map(function (link) { return d.getElementById(link.getAttribute('href').slice(1)); })
		.filter(Boolean);

	if ('IntersectionObserver' in window && sections.length) {
		var spy = new IntersectionObserver(function (entries) {
			entries.forEach(function (entry) {
				if (entry.isIntersecting) setCurrent(entry.target.id);
			});
		}, { rootMargin: '-30% 0px -60% 0px', threshold: 0 });

		sections.forEach(function (section) { spy.observe(section); });

		// At the very bottom of the page the last section is the current one.
		window.addEventListener('scroll', function () {
			var bottom = window.innerHeight + window.scrollY >= d.documentElement.scrollHeight - 2;
			if (bottom) setCurrent(sections[sections.length - 1].id);
		}, { passive: true });
	}

	/* ---------- Reveal on scroll ---------- */

	var reveals = Array.prototype.slice.call(d.querySelectorAll('.reveal'));

	if (!reduceMotion && 'IntersectionObserver' in window) {
		var revealer = new IntersectionObserver(function (entries, observer) {
			entries.forEach(function (entry) {
				if (entry.isIntersecting) {
					entry.target.classList.add('is-visible');
					observer.unobserve(entry.target);
				}
			});
		}, { rootMargin: '0px 0px -8% 0px', threshold: 0.02 });

		reveals.forEach(function (el) { revealer.observe(el); });
	} else {
		reveals.forEach(function (el) { el.classList.add('is-visible'); });
	}

	/* ---------- Typing animation ---------- */

	var typingElement = d.getElementById('typing-name');
	var caret = d.querySelector('.hero__caret');

	if (typingElement) {
		var finalText = 'Krzysztof Pytka';
		var misspellings = ['Krystof', 'Kzryzstof'];

		if (reduceMotion) {
			typingElement.textContent = finalText;
			if (caret) caret.parentNode.removeChild(caret);
		} else {
			var typeText = function (text, onComplete) {
				var charIndex = 0;
				var typeInterval = setInterval(function () {
					if (charIndex < text.length) {
						typingElement.textContent = text.substring(0, charIndex + 1);
						charIndex++;
					} else {
						clearInterval(typeInterval);
						setTimeout(onComplete, 200); // Wait before next action
					}
				}, 50); // Typing speed
			};

			var deleteText = function (onComplete) {
				var currentText = typingElement.textContent;
				var deleteInterval = setInterval(function () {
					if (currentText.length > 0) {
						currentText = currentText.substring(0, currentText.length - 1);
						typingElement.textContent = currentText;
					} else {
						clearInterval(deleteInterval);
						setTimeout(onComplete, 100); // Wait before typing next
					}
				}, 30); // Deletion speed
			};

			var currentMisspellingIndex = 0;

			var animateMisspellings = function () {
				if (currentMisspellingIndex < misspellings.length) {
					typeText(misspellings[currentMisspellingIndex], function () {
						setTimeout(function () {
							deleteText(function () {
								currentMisspellingIndex++;
								animateMisspellings();
							});
						}, 150); // Hold misspelling for 150ms
					});
				} else {
					// All misspellings done, type the final correct name
					setTimeout(function () {
						typeText(finalText, function () {
							if (caret) caret.classList.add('is-done');
						});
					}, 100);
				}
			};

			// Start the animation one second after load
			setTimeout(animateMisspellings, 1000);
		}
	}

	/* ---------- BibTeX dialog ---------- */

	var dialog = d.getElementById('bibtex-dialog');
	var output = d.getElementById('bibtex-output');
	var note = d.getElementById('bibtex-note');
	var copyBtn = d.getElementById('bibtex-copy');
	var copyLabel = copyBtn ? copyBtn.innerHTML : '';

	function showBibtex(bibtexId) {
		var source = d.getElementById(bibtexId);
		if (!source) return;

		var pre = source.querySelector('pre');
		var text = (pre ? pre.textContent : source.textContent).replace(/^\s+|\s+$/g, '');

		if (dialog && output && typeof dialog.showModal === 'function') {
			output.textContent = text;
			if (note) note.hidden = text.indexOf('pytka_runge_2025') === -1;
			if (copyBtn) copyBtn.innerHTML = copyLabel;
			dialog.showModal();
		} else {
			// Fallback for browsers without <dialog>: the standalone page.
			var url = 'bibtex-template.html?content=' + encodeURIComponent(source.innerHTML);
			window.open(url, '_blank', 'width=600,height=500,scrollbars=yes,resizable=yes');
		}
	}

	window.showBibtex = showBibtex;

	d.addEventListener('click', function (event) {
		var trigger = event.target.closest('[data-bibtex]');
		if (trigger) {
			event.preventDefault();
			showBibtex(trigger.getAttribute('data-bibtex'));
			return;
		}

		if (!dialog || !dialog.open) return;

		if (event.target.closest('[data-dialog-close]') || event.target === dialog) {
			dialog.close();
		}
	});

	function fallbackCopy(text) {
		var area = d.createElement('textarea');
		area.value = text;
		area.setAttribute('readonly', '');
		area.style.position = 'fixed';
		area.style.opacity = '0';
		d.body.appendChild(area);
		area.select();
		try { d.execCommand('copy'); } catch (err) { /* ignore */ }
		d.body.removeChild(area);
	}

	if (copyBtn && output) {
		copyBtn.addEventListener('click', function () {
			var text = output.textContent;
			var done = function () {
				copyBtn.innerHTML = '<svg class="icon" aria-hidden="true"><use href="#i-check"></use></svg> Copied!';
				setTimeout(function () { copyBtn.innerHTML = copyLabel; }, 2000);
			};

			if (navigator.clipboard && navigator.clipboard.writeText) {
				navigator.clipboard.writeText(text).then(done, function () {
					fallbackCopy(text);
					done();
				});
			} else {
				fallbackCopy(text);
				done();
			}
		});
	}
})();

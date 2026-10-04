/* Agenda Wilcoa - Service Worker
   Siempre intenta primero traer la versión más reciente desde el servidor.
   Solo si no hay internet usa la copia guardada. Así las actualizaciones
   de index.html llegan a todos los dispositivos sin quedarse con versiones viejas. */
const CACHE = 'wilcoa-shell-2026-10-04-r4';

self.addEventListener('install', () => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    const keys = await caches.keys();
    await Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)));
    await self.clients.claim();
  })());
});

self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;      // Firebase, fuentes, etc.: sin tocar
  if (url.searchParams.has('vcheck')) return;            // chequeo de versión: directo a la red

  event.respondWith((async () => {
    try {
      const fresh = await fetch(req, { cache: 'no-store' });
      if (fresh && fresh.ok) {
        const cache = await caches.open(CACHE);
        cache.put(req, fresh.clone());
      }
      return fresh;
    } catch (err) {
      const cached = await caches.match(req, { ignoreSearch: true });
      if (cached) return cached;
      if (req.mode === 'navigate') {
        const shell = (await caches.match('index.html')) || (await caches.match('./'));
        if (shell) return shell;
      }
      throw err;
    }
  })());
});

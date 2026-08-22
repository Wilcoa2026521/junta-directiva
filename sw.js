// Service worker mínimo — solo existe para que Chrome/Android
// considere la página "instalable". No cachea nada agresivo,
// así que la App siempre carga la versión más reciente.

self.addEventListener('install', (event) => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  // Deja pasar todas las peticiones directo a la red.
  event.respondWith(fetch(event.request));
});

importScripts('/_nuxt/workbox.4c4f5ca6.js')

workbox.precaching.precacheAndRoute([
  {
    "url": "/_nuxt/12ae2a0278dcf6bc8808.js",
    "revision": "cde1b6a3afa6c8c1e6a7c85c7dcb3467"
  },
  {
    "url": "/_nuxt/9272e98b132fb5c3e3c5.js",
    "revision": "d9762d6dd0c7869d347976fa0ddd21bc"
  },
  {
    "url": "/_nuxt/bcce4465bd31085f0d79.js",
    "revision": "33de6e252e352fec306aa48a5abb0833"
  },
  {
    "url": "/_nuxt/c7dd409fa2c474ab2cde.js",
    "revision": "b301670ddc56b6478f70254d78755878"
  },
  {
    "url": "/_nuxt/e24e91825e9949709b87.js",
    "revision": "5ba2b7752e6858124a5ae731c052a208"
  }
], {
  "cacheId": "tractor-beam",
  "directoryIndex": "/",
  "cleanUrls": false
})

workbox.clientsClaim()
workbox.skipWaiting()

workbox.routing.registerRoute(new RegExp('/_nuxt/.*'), workbox.strategies.cacheFirst({}), 'GET')

workbox.routing.registerRoute(new RegExp('/.*'), workbox.strategies.networkFirst({}), 'GET')

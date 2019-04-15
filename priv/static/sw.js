importScripts('/_nuxt/workbox.4c4f5ca6.js')

workbox.precaching.precacheAndRoute([
  {
    "url": "/_nuxt/118b5bac2f1a45ba6660.js",
    "revision": "1454ab8342845931654f6180baf5bb97"
  },
  {
    "url": "/_nuxt/7fbffa472b3f884bf16c.js",
    "revision": "56c845d7e7e33a04f1a6b7ce27315eda"
  },
  {
    "url": "/_nuxt/a1dbc4d50aa2462c1a86.js",
    "revision": "433c26683d1a0c78246f93c39eaa9bfa"
  },
  {
    "url": "/_nuxt/e1fd8f51d8f7588a8985.js",
    "revision": "7afcb56401d5b4ce626de43c61dc3dbc"
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

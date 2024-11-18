'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"main.dart.js": "fa694db2d1c1ffb7c48c8ebc709804e2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "a04b8155c189d23138e49b8ff1146301",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/assets/fonts/Roboto-Regular.ttf": "327362a7c8d487ad3f7970cc8e2aba8d",
"assets/assets/test_icon/step6_icon_6.png": "ff0e439df6bec317acd609e9a4651202",
"assets/assets/test_icon/step5_icon_2.png": "1971f8b857d1295a23c142e41e329947",
"assets/assets/test_icon/mouth_brushing_1.png": "76affb107f7e8621fbefcebfafe74af1",
"assets/assets/test_icon/step5_icon_4.png": "2da4f3f965e3c42aa439df659aadf25d",
"assets/assets/test_icon/center_icon_1.png": "8b0be80ba5f5ee0b6864740cb501bd69",
"assets/assets/test_icon/bottom_left_corner.png": "136e6533fc53e3d8ea9032f46181136c",
"assets/assets/test_icon/step6_icon_5.png": "e100b6519ab3c8039a7e0f32dcde4710",
"assets/assets/test_icon/tooth_btm.png": "075bb5e310b167d5d7f62e7f1d5ae08f",
"assets/assets/test_icon/close_icon.png": "619fe80d3a5c5c46fbe5345aef804a12",
"assets/assets/test_icon/mouth_brushing_2.png": "34ebbf066f799a7758babf4652fcaa93",
"assets/assets/test_icon/main_icon_1.png": "7312db6b943fa076e22838023199d2af",
"assets/assets/test_icon/tooth_time.png": "a553a6baf81e844deb6693c2e429858c",
"assets/assets/test_icon/step6_icon_4.png": "6a5949af1de9287b51ff30e35031b8a8",
"assets/assets/test_icon/step5_icon_5.png": "307032a22a4469fbd71441e81d4d15ff",
"assets/assets/test_icon/bottom_right_corner.png": "875232d450e67be24e8b3bd3f14e06cf",
"assets/assets/test_icon/center_icon_2.png": "2447f0e93447a45df9696680b6e9f9a2",
"assets/assets/test_icon/step6_icon_3.png": "e9063bf09dfbe6640693311e54b96fd4",
"assets/assets/test_icon/main_icon_3.png": "de436838058461ddf0671a4728475a2a",
"assets/assets/test_icon/main_icon_4.png": "6947ad81e3f021c50368d9b55da48e7d",
"assets/assets/test_icon/user_image.png": "5b38fae96b268c7461e682e2add32b97",
"assets/assets/test_icon/step5_icon_3.png": "e5da1b9414c3558eb9073c9870f03224",
"assets/assets/test_icon/top_right_corner.png": "ca666fd6621da5e14173744aaf99b605",
"assets/assets/test_icon/main_icon_2.png": "653d6d5973d9c5fc171b2dff9d1938ee",
"assets/assets/test_icon/main_icon_7.png": "4cd6eb0f829f56216a184b757aff19fe",
"assets/assets/test_icon/top_left_corner.png": "019c089c05a434a09f03ebb311233d46",
"assets/assets/test_icon/main_icon_5.png": "d2e1cfde1faab2206deac56f883786af",
"assets/assets/test_icon/main_icon_6.png": "cabc3bb40da325f113cad8e7bbc3eb38",
"assets/assets/test_icon/tooth_top.png": "b90dde75a223b366e505f5a42f6501cd",
"assets/assets/test_icon/center_icon.png": "3d167b409c6f609bbe4d5af2b556c0a9",
"assets/assets/test_icon/step6_icon_2.png": "a2413ebcdff372b27fbbc02f9f372a20",
"assets/assets/test_icon/step5_icon_1.png": "5d395f5172ccdc6a3b697dd11af62e6b",
"assets/assets/test_icon/mouth_brushing.png": "741f97c5eba0f31ef748198d5feb8155",
"assets/assets/test_icon/step6_icon_1.png": "60763090d654580e1b7e68193eb41eb9",
"assets/assets/images/ad1.png": "9f233503dca597c80b59ebd86fdfb480",
"assets/assets/icons/before_smile.svg": "31b639d62eb8802a294a9950a2e5e59d",
"assets/assets/icons/blue_plus.svg": "03e7670f97b6038713cde9b9ddbc523b",
"assets/assets/icons/Smile.svg": "4de254994160849042da7d5bdd19bd90",
"assets/assets/icons/alert_gray_rounded.svg": "fd46e86155a99b81ebbf72270805c6d4",
"assets/assets/icons/plus.svg": "51da4344e297d31c01d0e1b169c1a69f",
"assets/NOTICES": "bf7971b731f91e901d5fe53b8fdb4f2c",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "1f7027cb93dd661ca453ff508784e761",
"index.html": "5dd592ec70bfd49e1724242c19f510de",
"/": "5dd592ec70bfd49e1724242c19f510de",
"manifest.json": "7c753c8415b8278e5db63974d792e748",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "f0aa2613ca08d4fad50e06af77b940f7",
"geolocation.js": "971d54e840f6c1c1d9ae2cf4074588be"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

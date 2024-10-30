Quick Build Laravel + Inertia + Vue Project the batch file

This batch file include

PHP package will install
1. latest version Laravel
2. inertia
3. ziggy

Js package will install
1. vite
2. vitejs-plugin-vie
3. inertiajs
4. bootstrap
5. sass-embedded
6. laravel-vite-plugin

Will overwrite files:
1. vite.config.js
```javascript
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js', 'resources/scss/app.scss'],
            refresh: true,
        }),
        vue()
    ],
});
```

2. app.blade.php
```blade
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title inertia>{{ config('app.name', 'Laravel') }}</title>
    @vite(['resources/js/app.js', 'resources/css/app.css', 'resources/scss/app.scss'])
    @inertiaHead
</head>
<body class="font-sans antialiased">
    @inertia
</body>
</html>
```

3. app.js
```javascript
import './bootstrap';
import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/inertia-vue3';

createInertiaApp({
    resolve: name => import(`./Pages/${name}.vue`),
    setup({ el, App, props, plugin }) {
        const vue_app = createApp({ render: () => h(App, props) })
            .use(plugin)
        
        vue_app.mount(el);
    },
});
```

4. app.css
```css
@import 'bootstrap/dist/css/bootstrap.min.css';
```

5. resources\js\Pages\Home.vue
```vue
<template>
    <div class="d-flex vh-100 w-100">
        Hello, World!
    </div>
</template>
```
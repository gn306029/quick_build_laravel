setlocal
chcp 65001

:: 快速建立 laravel inertia vue3 vite 的項目 ::
:: 使用前先確保 composer 與 node 已安裝 ::
:: 1. 讓使用者輸入專案名稱 ::
set /p projectName="Project Name(English): "

:: 1. 建立 laravel 專案 ::
call composer create-project laravel/laravel %projectName% --prefer-dist
cd %projectName%

:: 2. 安裝 inertia ::
call composer require inertiajs/inertia-laravel
call composer require tightenco/ziggy

:: 3. 安裝 inertia-vue 與 其他相關套件 ::
call npm install vite@latest 
call npm install @inertiajs/inertia 
call npm install @inertiajs/inertia-vue3
call npm install @vitejs/plugin-vue
call npm install bootstrap@5.3.3
call npm install -D sass-embedded
call npm install -D laravel-vite-plugin

:: 4. 設定 vite.config.js ::
echo import { defineConfig } from 'vite'; > vite.config.js
echo import vue from '@vitejs/plugin-vue'; >> vite.config.js
echo import laravel from 'laravel-vite-plugin'; >> vite.config.js
echo. >> vite.config.js
echo export default defineConfig({ >> vite.config.js
echo     plugins: [ >> vite.config.js
echo         laravel({ >> vite.config.js
echo             input: ['resources/css/app.css', 'resources/js/app.js', 'resources/scss/app.scss'], >> vite.config.js
echo             refresh: true, >> vite.config.js
echo         }), >> vite.config.js
echo         vue() >> vite.config.js
echo     ], >> vite.config.js
echo }); >> vite.config.js

:: 5. 設定 app.blade.php ::
echo ^<!DOCTYPE html^> > resources/views/app.blade.php
echo ^<html lang="{{ str_replace('_', '-', app()->getLocale()) }}"^> >> resources/views/app.blade.php
echo ^<head^> >> resources/views/app.blade.php
echo     ^<meta charset="utf-8"^> >> resources/views/app.blade.php
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1"^> >> resources/views/app.blade.php
echo     ^<title inertia^> {{ config('app.name', 'Laravel') }} ^</title^> >> resources/views/app.blade.php
echo     @vite(['resources/js/app.js', 'resources/css/app.css', 'resources/scss/app.scss']) >> resources/views/app.blade.php
echo     @routes >> resources/views/app.blade.php
echo     @inertiaHead >> resources/views/app.blade.php
echo ^</head^> >> resources/views/app.blade.php
echo ^<body class="font-sans antialiased"^> >> resources/views/app.blade.php
echo     @inertia >> resources/views/app.blade.php
echo ^</body^> >> resources/views/app.blade.php
echo ^</html^> >> resources/views/app.blade.php


:: 6. 設定 app.js ::
echo import './bootstrap'; > resources/js/app.js
echo import { createApp, h } from 'vue'; >> resources/js/app.js
echo import { createInertiaApp } from '@inertiajs/inertia-vue3'; >> resources/js/app.js
echo. >> resources/js/app.js
echo createInertiaApp({ >> resources/js/app.js
echo     resolve: name =^> import(`./Pages/${name}.vue`), >> resources/js/app.js
echo     setup({ el, App, props, plugin }) { >> resources/js/app.js
echo         const vue_app = createApp({ render: () =^> h(App^, props) }) >> resources/js/app.js
echo             .use(plugin) >> resources/js/app.js
echo. >> resources/js/app.js
echo         vue_app.mount(el); >> resources/js/app.js
echo     }, >> resources/js/app.js
echo }); >> resources/js/app.js


:: 7. 設定 app.css ::
echo @import 'bootstrap/dist/css/bootstrap.min.css'; > resources/css/app.css

:: 8. 建立 Pages 資料夾 ::
if not exist .\resources\js\Pages (
    mkdir .\resources\js\Pages
)

:: 9. 建立 Home.vue ::
echo ^<template^> > resources/js/Pages/Home.vue
echo     ^<div^> >> resources/js/Pages/Home.vue
echo         ^<h1^>Hello, World!^</h1^> >> resources/js/Pages/Home.vue
echo     ^</div^> >> resources/js/Pages/Home.vue
echo ^</template^> >> resources/js/Pages/Home.vue
echo. >> resources/js/Pages/Home.vue
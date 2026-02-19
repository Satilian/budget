import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';
import { pluginTypedCSSModules } from '@rsbuild/plugin-typed-css-modules';
import fs from 'node:fs';

export default defineConfig({
  plugins: [pluginReact(), pluginTypedCSSModules()],
  server: {
    proxy: {
      '/api': {
        target: 'https://localhost:8080',
        changeOrigin: true,
        secure: false,
      },
    },
    https: {
      key: fs.readFileSync('certificates/budget.local+1-key.pem'),
      cert: fs.readFileSync('certificates/budget.local+1.pem'),
    },
  },
  html: {
    title: 'Family budget',
    template: './src/assets/index.html',
    favicon: './src/assets/favicon-32x32.png',
    tags: [
      {
        tag: 'link',
        attrs: { rel: 'manifest', href: './src/assets/site.webmanifest' },
      },
    ],
  },
});

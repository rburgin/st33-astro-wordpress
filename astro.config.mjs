import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  output: 'server',
  adapter: cloudflare({
    mode: 'directory',
  }),
  site: 'https://your-site.pages.dev', // Update with your Cloudflare Pages URL
});

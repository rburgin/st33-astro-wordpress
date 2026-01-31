import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  output: 'server',
  adapter: cloudflare({
    mode: 'directory',
  }),
  site: 'https://st33.com', // Your production domain
  image: {
    service: {
      entrypoint: 'astro/assets/services/noop'
    }
  }
});

import { cpSync, mkdirSync, rmSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
const root=resolve('..');const dest=resolve('www');
rmSync(dest,{recursive:true,force:true});mkdirSync(dest,{recursive:true});
for(const name of ['index.html','auth.js','app.js','styles.css','config.js','manifest.webmanifest','sw.js','icon-192.png','icon-512.png','privacidade.html']){
  const src=resolve(root,name);if(!existsSync(src)) throw new Error(`Arquivo ausente: ${src}`);
  cpSync(src,resolve(dest,name));
}
console.log('Arquivos de web copiados para www/. Configure os links de autenticação antes de distribuir nativamente.');

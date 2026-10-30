# Publicar MedAtlas na Google Play e App Store

A versão web é uma PWA, instalável gratuitamente pelo Chrome/Safari. **Arquivos deste pacote não são APK, AAB ou IPA**. Para colocá-la nas lojas, será preciso criar aplicativos nativos assinados, testar e passar pela avaliação de cada loja.

## Android (Google Play)

- Criar uma conta de desenvolvedor em https://play.google.com/console/ . A inscrição geralmente custa **US$ 25 uma única vez**, além de verificação de identidade e outros requisitos da plataforma.
- Para contas pessoais novas, o Google exige **teste fechado com ao menos 12 testadores durante 14 dias consecutivos** antes da solicitação de acesso à produção.
- Criar projeto Android via **Capacitor**, preparar chave de assinatura, gerar o **Android App Bundle (AAB)**, ícones/capturas, política de privacidade, classificação indicativa e formulário Data safety; enviar pelo Play Console.

## iPhone/iPad (App Store)

- Inscrever-se no https://developer.apple.com/programs/enroll/ . A taxa padrão é **US$ 99 por ano** (conversão/condições locais variam), salvo possível isenção para organizações elegíveis.
- Criar o projeto iOS com Capacitor, abrir com **Xcode em um Mac compatível**, configurar assinatura, requisitos de privacidade e capturas, enviar no App Store Connect e passar pela revisão.
- A Apple pode rejeitar aplicativos que sejam apenas uma página web empacotada, sem funcionalidade adequada de aplicativo. Melhorar experiências nativas antes de enviar.

## Preparação do código

O projeto é HTML/CSS/JavaScript e pode ser migrado para Capacitor com os passos gerais (em computador com Node):

```bash
npm install @capacitor/core @capacitor/cli @capacitor/android @capacitor/ios
npx cap init MedAtlas br.com.medatlas.estudos --web-dir=www
# preparar www/ com index.html, scripts, estilos, imagens e config.js
npx cap add android
npx cap add ios
npx cap sync
```

**Atenção:** o cadastro por e-mail, recuperação de senha e URLs de redirecionamento precisarão ser adaptados a deep links dos aplicativos nativos. Não use as URLs do GitHub Pages como substitutos dos callbacks nativos sem testar. Revise o cache offline, consentimento, exclusão de conta, política de privacidade e fluxo de recuperação de senha.

## Checklist mínimo antes das lojas

- Backend Supabase configurado e testado com mais de uma conta.
- Política de privacidade definitiva, responsável e canal de suporte válidos.
- Contas de desenvolvedor Google/Apple em nome do responsável, com taxas pertinentes pagas.
- Testes Android/iOS reais, erros e feedbacks corrigidos.
- Dados de pacientes proibidos, conteúdo médico revisado e aviso de uso educacional.
- Gerar e assinar AAB/IPA em ambiente de build apropriado.
- Preparar screenshots reais e metadados, submeter e aguardar aprovação.

**Ninguém pode garantir aprovação das lojas sem essas verificações.**

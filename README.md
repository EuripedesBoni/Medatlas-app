# MedAtlas — preparação Android e iOS com Capacitor

Este diretório é apenas a **estrutura inicial** do projeto nativo, **não** é um APK, AAB ou IPA e **não** está pronto para envio às lojas.

Requisitos: Node 22+, Android Studio e/ou macOS com Xcode, contas de desenvolvedor e chaves de assinatura.

1. Configure e valide autenticação e sincronização Supabase no PWA, inclusive políticas RLS e exclusão da conta.
2. Execute `cd native && npm install && npm run prepare:web`.
3. Execute `npx cap add android` ou `npx cap add ios`.
4. Para Android: `npx cap sync android && npx cap open android` (gerar AAB no Android Studio).
5. Para iOS: `npx cap sync ios && npx cap open ios` (configurar assinatura no Xcode e distribuir via App Store Connect).
6. Configure **deep links e redirecionamentos Auth** para confirmações de e-mail e recuperação de senha no app nativo. Os redirecionamentos web do PWA não bastam no contêiner nativo.
7. Adicione uma experiência adequada aos dispositivos, tela de privacidade definitiva, suporte, acessibilidade, capturas das telas, classificação etária, declaração de dados e contas de demonstração para avaliação.

A Apple pode rejeitar aplicativos que apenas encapsulem um site; veja seção 4.2 das App Review Guidelines. Não use o bundle ID de exemplo sem conferir unicidade e titularidade.

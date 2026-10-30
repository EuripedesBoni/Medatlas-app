# MEDATLAS 3.0 — CONTAS E SINCRONIZAÇÃO

**Status:** versão preparada para conectar a um projeto Supabase. Não contém credenciais reais, banco provisionado, app nas lojas, nem teste fim a fim com contas reais. O aplicativo atual em https://euripedesboni.github.io/Medatlas-app/ permanece publicado na versão anterior até a próxima atualização manual do GitHub.

## O que já está no código

- Tela de cadastro/login individual por e-mail e senha (Supabase Auth).
- Confirmação por e-mail, recuperação de senha e saída.
- Perfil e dados de estudo isolados por usuário, com políticas de segurança RLS no banco.
- Sincronização em nuvem, cache local segregado por conta, detecção de conflitos por revisão.
- Primeira importação opcional do histórico salvo pela versão antiga no mesmo dispositivo.
- Exclusão de conta e dados (executar função SQL antes de habilitar).
- PWA com manifesto, ícones, conteúdo médico de demonstração e os recursos da versão anterior.

## O que ainda precisa de serviço externo

1. Conectar/criar projeto Supabase — usar `CONFIGURAR.md`.
2. Aplicar e testar `schema.sql` em um ambiente Supabase real.
3. Preencher `config.js` com URL e chave **publicável** desse projeto (nunca chave secreta).
4. Ajustar política de privacidade com identificação e contato do responsável.
5. Testar com estudantes A e B, dois dispositivos e recuperação de senha.
6. Enviar somente após estar funcionando para GitHub Pages.
7. Para Play Store/App Store: ler `LOJAS_ANDROID_IOS.md`, providenciar contas de desenvolvedor, compilações nativas, certificados, testes e revisão.

**Observação:** este MVP usa registro JSON de estudo por usuário, com atualização otimista protegida por revisão. Não mescla edições simultâneas automaticamente; oferece resolução manual de conflitos e exportação de backup. Para muitos usuários ou uso intensivo, será necessária evolução para modelo por entidades e testes em produção.

# MedAtlas 3.0 — implantação de contas e sincronização (teste)

## O que já existe neste pacote

- Telas **Entrar / Criar conta / Esqueci minha senha / Alterar senha**.
- Autenticação por e-mail e senha via **Supabase Auth**.
- Salvamento do progresso no banco com políticas **Row Level Security** por ID de usuário.
- Revisão otimista para detecção de alterações simultâneas (em caso de conflito, o usuário escolhe qual versão manter; **não há mesclagem automática**).
- Dados locais identificados por usuário, exportação de backup JSON, migração opcional dos dados antigos na primeira entrada sem registro na nuvem.
- Tela de exclusão de conta e dados, sujeita a validação da função SQL.

**Importante**: cadastro, login, sincronização e exclusão **não estão ativos** até criar e configurar o projeto Supabase, aplicar o SQL e testar com duas contas. A versão publicada anteriormente no GitHub permanece funcional e não deve ser substituída até terminar estas etapas.

## 1. Preparar o banco de dados gratuito

1. Abra https://supabase.com/dashboard e crie uma conta/projeto Supabase (plano Free pode atender ao protótipo; possui limites).
2. Na área **SQL Editor**, execute o conteúdo de `schema.sql`, verifique se não houve erros.
3. No menu **Authentication → Providers → Email**, habilite e-mail/senha e mantenha confirmação de e-mail para o lançamento. Configure o SMTP para uso real com vários estudantes: o envio padrão pode ter limites.
4. Em **Authentication → URL Configuration**, defina:
   - Site URL: `https://euripedesboni.github.io/Medatlas-app/`
   - Redirect URLs: `https://euripedesboni.github.io/Medatlas-app/`
   - Para versões nativas, configurar deep links separadamente (não pronto neste pacote).
5. Em **Project Settings → API Keys**, copie somente:
   - Project URL: `https://...supabase.co`
   - `publishable` key (ou chave pública legacy `anon`).
6. Preencha `config.js` (campos `supabaseUrl` e `publishableKey`). **NUNCA copie service_role ou secret key para o site.** Essa chave pública poderá ser vista por qualquer pessoa: a privacidade depende das políticas RLS.

## 2. Testar antes de abrir a todos

- Teste cadastro, verificação do e-mail, login, recuperação de senha e exclusão da conta.
- Crie **duas contas distintas** e confirme que dados do usuário A não podem ser lidos nem modificados pelo usuário B.
- Abra **a mesma conta** em iPad e Android, atualize uma tarefa, volte ao outro aparelho; teste conflito ao editar dois aparelhos sem rede.
- Faça backup JSON do app atual **antes da atualização** (menu de relatórios/configurações).
- Faça o teste sem rede e, ao religar a conexão, verifique a sincronização pendente. O modo offline depende do cache e de uma sessão já ativa; autenticação inicial requer conexão.
- Finalize o texto da política de privacidade e canal de contato; **não** processe dados pessoais de pacientes no app.

## 3. Publicar nova versão após testar

1. Descompacte o pacote, envie os arquivos da pasta principal do projeto `MedAtlas_3_contas_sincronizacao` ao repositório GitHub Pages, **exceto** scripts internos de teste e o diretório `native` (pode guardar em pasta separada).
2. Substitua `index.html` e `sw.js` e envie `auth.js`, `app.js`, `styles.css`, `config.js`, `schema.sql` (o SQL pode ficar privado; preferível não publicar detalhes de migração), `privacidade.html` e ícones.
3. GitHub Pages publica a partir de `main` / root e o endereço continua https://euripedesboni.github.io/Medatlas-app/.

## 4. Google Play e App Store

- Com o **PWA**, o link é gratuito e instalável como atalho/app nos aparelhos.
- Para **Google Play**, é necessário compilação Android, assinatura, cadastro de desenvolvedor e submissão. A taxa de inscrição é normalmente **US$ 25 uma vez** e contas pessoais novas estão sujeitas a exigências de testes.
- Para **App Store**, a assinatura padrão do Apple Developer Program é **US$ 99 por ano**, exige macOS/Xcode, assinatura e revisão da Apple.
- Estrutura inicial disponível em `native/`; **não há APK, AAB ou IPA pronto**.
- Um aplicativo que somente encapsula um site pode ser rejeitado pela Apple; exigir conformidade com App Review Guidelines 4.2 e 5.1.1(v).

## Segurança

Nunca envie códigos de verificação, senha ou chaves secretas na conversa. Senhas ficam sob tratamento do Supabase Auth; não são guardadas em `medatlas_state` nem no código do site. Este pacote é protótipo de implantação e requer testes com o backend real antes de anunciar contas prontas.

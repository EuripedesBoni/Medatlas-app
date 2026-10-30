# MedAtlas 3.0 — ativar cadastro e sincronização

**Situação:** código implementado; sem projeto Supabase associado, o cadastro permanecerá bloqueado. **Não substitua os arquivos do site público antes de configurar e testar o backend.** O GitHub Pages hospeda a interface, mas não fornece sozinho banco ou login.

## Primeiro, crie o projeto Supabase

1. Abra https://supabase.com/dashboard e crie uma conta/projeto chamado `medatlas` (plano Free, sujeito aos limites atuais do serviço). Salve a senha do banco **somente no painel/gerenciador de senhas**, não no chat, no GitHub ou no `config.js`.
2. Abra **SQL Editor** do projeto e execute o conteúdo do arquivo `schema.sql` deste pacote. Confira que a tabela `public.medatlas_state` e a função `medatlas_delete_my_account` existem.
3. No painel de **Authentication → Providers → Email**, mantenha inscrição por e-mail/senha habilitada e **confirmação de e-mail ativada** para uso público. Verifique os limites de e-mails transacionais e configure SMTP próprio ao escalar o uso.
4. Em **Authentication → URL Configuration**, configure:
   - **Site URL:** `https://euripedesboni.github.io/Medatlas-app/`
   - **Redirect URLs:** `https://euripedesboni.github.io/Medatlas-app/`
5. Em **Project Settings → API Keys** (ou **Connect**), copie só **Project URL** e **Publishable key**, começando em `sb_publishable_`. Insira-as em `config.js`:

```js
window.MEDATLAS_CONFIG = {
  supabaseUrl: 'https://SEU-PROJETO.supabase.co',
  publishableKey: 'sb_publishable_SUA-CHAVE-PUBLICA'
};
```

**Nunca** use `sb_secret_...`, `service_role`, tokens privados ou senha do banco em arquivos públicos, no GitHub ou no chat. A publishable key **não é segredo**: o acesso aos dados deve ser protegido pelas políticas de RLS.

## Testes obrigatórios antes de liberar cadastro

1. Em uma aba privativa, crie a conta do **Estudante A** com e-mail de teste, confirme o e-mail e entre. Crie uma tarefa e aguarde "Sincronizado".
2. No tablet ou outro navegador, entre como **o mesmo estudante**, confira a tarefa e altere-a. Volte ao primeiro aparelho e atualize a aba ou alterne o foco: os dados devem aparecer atualizados.
3. Crie o **Estudante B** e confirme que ele não visualiza tarefas, questões respondidas ou perfil do A.
4. Desligue temporariamente a conexão e faça uma edição numa sessão previamente autenticada (quando suportada); confirme o aviso de alteração pendente e teste posterior reconexão.
5. Faça uma alteração nos dois aparelhos antes da sincronização e confira o aviso de **conflito**, que evita sobrescrever dados silenciosamente. Teste o backup antes de escolher uma versão.
6. Teste o botão de recuperação de senha, a confirmação de e-mail, saída da conta e a exclusão total **com uma conta descartável**.
7. Verifique RLS para `select`, `insert`, `update`, `delete`: uma conta autenticada não deve operar dados de outra. Faça um teste de segurança independente antes de produção.
8. **Edite `privacidade.html`** e adicione contato do responsável antes do lançamento.

## Publicação no GitHub

Depois de executar SQL e configurar `config.js`, acesse https://github.com/EuripedesBoni/Medatlas-app , escolha **Add file → Upload files** e substitua os arquivos de raiz pelos arquivos deste pacote (sem enviar `schema.sql`, já executado no banco, e documentos privados). Aguarde o GitHub Pages marcar o deploy com **Success**.

> O MedAtlas 3.0 exige autenticação para abrir dados. Não coloque uma senha igual para todos. Cada estudante cria sua senha e pode recuperá-la por e-mail.

## Sobre sincronização

- Cada usuário possui um registro privado na tabela `medatlas_state`.
- Alterações são salvas no navegador e enviadas à nuvem; o segundo dispositivo busca atualizações quando ganha foco e a cada ~20s enquanto aberto.
- Uma revisão (`revision`) evita sobrescrita automática se dois aparelhos alteraram os mesmos dados simultaneamente. O usuário escolhe qual versão preservar e pode exportar backups.
- Este mecanismo é adequado a um **MVP**, não oferece mesclagem automática de alterações concorrentes nem sincronização offline garantida em todos os navegadores. Antes de escala, implementar sincronização por tarefa/registro e testes de integração abrangentes.
- Em PWA, acesso inicial, login, recuperação de senha e sincronização exigem internet. O cache de interface não significa que todo o fluxo de autenticação esteja disponível offline.

### Configuração sem editar código manualmente

Abra `ASSISTENTE_CONFIGURACAO.html` no navegador, preencha somente a URL pública do projeto e a chave `publishable` (nunca a `service_role`), e baixe um `config.js` pronto para enviar ao GitHub junto dos arquivos da versão 3.1. Antes de enviar, aplique `schema.sql` e faça o teste com duas contas e dois navegadores.

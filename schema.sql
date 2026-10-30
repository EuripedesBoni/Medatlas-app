-- MedAtlas 3.0: Execute no SQL Editor do Supabase, uma única vez.
-- Dados privados: cada usuário só lê e modifica os próprios estudos.
create table if not exists public.medatlas_state (
    user_id uuid primary key references auth.users(id) on delete cascade,
    data jsonb not null,
    revision bigint not null default 1 check (revision >= 1),
    updated_at timestamptz not null default now(),
    constraint medatlas_payload_limit check (pg_column_size(data) <= 4000000)
);

create or replace function public.medatlas_touch_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin new.updated_at = now(); return new; end;
$$;
drop trigger if exists medatlas_timestamp on public.medatlas_state;
create trigger medatlas_timestamp before update on public.medatlas_state
for each row execute function public.medatlas_touch_updated_at();

alter table public.medatlas_state enable row level security;
revoke all on public.medatlas_state from anon, authenticated;
grant select,insert,update,delete on public.medatlas_state to authenticated;

drop policy if exists medatlas_select_own on public.medatlas_state;
create policy medatlas_select_own on public.medatlas_state for select to authenticated
using (user_id = (select auth.uid()));
drop policy if exists medatlas_insert_own on public.medatlas_state;
create policy medatlas_insert_own on public.medatlas_state for insert to authenticated
with check (user_id = (select auth.uid()));
drop policy if exists medatlas_update_own on public.medatlas_state;
create policy medatlas_update_own on public.medatlas_state for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
drop policy if exists medatlas_delete_own on public.medatlas_state;
create policy medatlas_delete_own on public.medatlas_state for delete to authenticated
using (user_id = (select auth.uid()));

-- Exclusão da própria conta para cumprimento das regras de privacidade e das lojas.
-- A função roda com o dono do objeto (no SQL Editor), restringindo a exclusão ao JWT atual.
create or replace function public.medatlas_delete_my_account()
returns void language plpgsql security definer set search_path = '' as $$
declare current_user_id uuid;
begin
  current_user_id := (select auth.uid());
  if current_user_id is null then
    raise exception 'Autenticação obrigatória';
  end if;
  delete from auth.users where id = current_user_id;
end;
$$;
revoke all on function public.medatlas_delete_my_account() from public, anon;
grant execute on function public.medatlas_delete_my_account() to authenticated;
-- Validar RLS, exclusão, senhas, bloqueio de usuários cruzados e conflitos em ambiente de testes antes de produção.

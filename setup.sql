-- Dad's Bill Book: run this once in Supabase (SQL Editor -> New query -> paste -> Run).
-- It creates one private table. Each signed-in person can only read and change their own row.

create table if not exists public.app_state (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

drop policy if exists "Read own bills"   on public.app_state;
drop policy if exists "Add own bills"    on public.app_state;
drop policy if exists "Change own bills" on public.app_state;

create policy "Read own bills" on public.app_state
  for select to authenticated using (auth.uid() = user_id);

create policy "Add own bills" on public.app_state
  for insert to authenticated with check (auth.uid() = user_id);

create policy "Change own bills" on public.app_state
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Run this once in Supabase Dashboard -> SQL Editor.
-- One row per authenticated user. The full dashboard progress object is stored as JSONB.

create table if not exists public.study_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.study_state enable row level security;

drop policy if exists "Users can read own study state" on public.study_state;
create policy "Users can read own study state"
on public.study_state
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert own study state" on public.study_state;
create policy "Users can insert own study state"
on public.study_state
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update own study state" on public.study_state;
create policy "Users can update own study state"
on public.study_state
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own study state" on public.study_state;
create policy "Users can delete own study state"
on public.study_state
for delete
to authenticated
using (auth.uid() = user_id);

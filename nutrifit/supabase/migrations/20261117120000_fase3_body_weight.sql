-- Fase 3: datos corporales, peso objetivo y registro de peso (weight_logs).
-- Project: NutriFit (oqtjnmqnenxrfpuzrzad)
--
-- 1. profiles: height_cm y goal_weight_kg (nullable: usuarios previos no los tienen).
-- 2. weight_logs: un peso por usuario y dia, con RLS.
-- 3. handle_new_user: toma los datos corporales de raw_user_meta_data (los envia el
--    registro) y crea el primer weight_log. Se hace en el trigger porque el signUp
--    puede no devolver sesion (confirmacion de correo) y asi no depende del cliente.

-- 1. Profiles ---------------------------------------------------------------
alter table public.profiles
  add column if not exists height_cm numeric
    check (height_cm is null or height_cm between 50 and 260);

alter table public.profiles
  add column if not exists goal_weight_kg numeric
    check (goal_weight_kg is null or goal_weight_kg between 20 and 500);

-- 2. Weight logs ------------------------------------------------------------
create table if not exists public.weight_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  date date not null default current_date,
  weight_kg numeric not null check (weight_kg between 20 and 500),
  created_at timestamptz not null default now(),
  unique (user_id, date)
);

alter table public.weight_logs enable row level security;

drop policy if exists "weight_owner_select" on public.weight_logs;
create policy "weight_owner_select" on public.weight_logs
  for select using (auth.uid() = user_id);

drop policy if exists "weight_owner_insert" on public.weight_logs;
create policy "weight_owner_insert" on public.weight_logs
  for insert with check (auth.uid() = user_id);

drop policy if exists "weight_owner_update" on public.weight_logs;
create policy "weight_owner_update" on public.weight_logs
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "weight_owner_delete" on public.weight_logs;
create policy "weight_owner_delete" on public.weight_logs
  for delete using (auth.uid() = user_id);

-- Realtime (mismo patron que la Fase 2)
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'weight_logs'
  ) then
    alter publication supabase_realtime add table public.weight_logs;
  end if;
end $$;

-- 3. Alta de usuario con datos corporales -----------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  v_height numeric;
  v_weight numeric;
  v_goal_weight numeric;
  v_weight_date date;
  v_goal text;
begin
  -- Los datos corporales son opcionales: un valor invalido nunca debe
  -- bloquear el registro, simplemente se ignora.
  begin
    v_height := nullif(new.raw_user_meta_data ->> 'height_cm', '')::numeric;
    v_weight := nullif(new.raw_user_meta_data ->> 'weight_kg', '')::numeric;
    v_goal_weight := nullif(new.raw_user_meta_data ->> 'goal_weight_kg', '')::numeric;
    v_weight_date := nullif(new.raw_user_meta_data ->> 'weight_date', '')::date;
  exception when others then
    v_height := null;
    v_weight := null;
    v_goal_weight := null;
    v_weight_date := null;
  end;

  if v_height is not null and v_height not between 50 and 260 then
    v_height := null;
  end if;
  if v_weight is not null and v_weight not between 20 and 500 then
    v_weight := null;
  end if;
  if v_goal_weight is not null and v_goal_weight not between 20 and 500 then
    v_goal_weight := null;
  end if;

  v_goal := new.raw_user_meta_data ->> 'goal';
  if v_goal is null or v_goal not in ('lose', 'maintain', 'gain') then
    v_goal := 'maintain';
  end if;

  insert into public.profiles (id, email, name, goal, height_cm, goal_weight_kg)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'name', split_part(new.email, '@', 1)),
    v_goal,
    v_height,
    v_goal_weight
  )
  on conflict (id) do nothing;

  -- weight_date lo manda el cliente (fecha local): current_date del servidor
  -- es UTC y caeria en "manana" para usuarios en America de noche.
  if v_weight is not null then
    insert into public.weight_logs (user_id, date, weight_kg)
    values (new.id, coalesce(v_weight_date, current_date), v_weight)
    on conflict (user_id, date) do nothing;
  end if;

  return new;
end;
$$;

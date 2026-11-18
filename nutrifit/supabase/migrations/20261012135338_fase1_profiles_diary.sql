-- Fase 1: profiles + diary_entries with RLS.
-- Linked project: NutriFit (oqtjnmqnenxrfpuzrzad).

-- Profiles (1:1 with auth.users)
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text,
  name text,
  goal text not null default 'maintain' check (goal in ('lose', 'maintain', 'gain')),
  activity_level text not null default 'moderate'
    check (activity_level in ('sedentary', 'light', 'moderate', 'active')),
  calorie_target integer not null default 2200 check (calorie_target between 800 and 10000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Diary entries (one row per food added to a meal)
create table if not exists public.diary_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  date date not null default current_date,
  meal_type text not null check (meal_type in ('breakfast', 'lunch', 'dinner', 'snack')),
  food_name text not null,
  grams numeric not null default 100 check (grams > 0),
  kcal numeric not null default 0 check (kcal >= 0),
  protein numeric not null default 0 check (protein >= 0),
  carbs numeric not null default 0 check (carbs >= 0),
  fat numeric not null default 0 check (fat >= 0),
  source text not null default 'manual' check (source in ('manual', 'scan', 'recipe')),
  created_at timestamptz not null default now()
);

create index if not exists diary_entries_user_date_idx
  on public.diary_entries (user_id, date);

-- Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email, name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'name', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- RLS
alter table public.profiles enable row level security;
alter table public.diary_entries enable row level security;

drop policy if exists "profiles_owner" on public.profiles;
create policy "profiles_owner" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "diary_owner_select" on public.diary_entries;
create policy "diary_owner_select" on public.diary_entries
  for select using (auth.uid() = user_id);

drop policy if exists "diary_owner_insert" on public.diary_entries;
create policy "diary_owner_insert" on public.diary_entries
  for insert with check (auth.uid() = user_id);

drop policy if exists "diary_owner_update" on public.diary_entries;
create policy "diary_owner_update" on public.diary_entries
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "diary_owner_delete" on public.diary_entries;
create policy "diary_owner_delete" on public.diary_entries
  for delete using (auth.uid() = user_id);

-- Fase 2: habilita Supabase Realtime (postgres_changes) sobre las tablas
-- del usuario, para que la UI refleje cambios sin cerrar sesión.
-- Project: NutriFit (oqtjnmqnenxrfpuzrzad)

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'diary_entries'
  ) then
    alter publication supabase_realtime add table public.diary_entries;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'profiles'
  ) then
    alter publication supabase_realtime add table public.profiles;
  end if;
end $$;

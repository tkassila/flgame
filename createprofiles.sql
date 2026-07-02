
-- Luodaan profiles-taulu
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  username text unique,
  avatar_url text,
  elo_rating integer default 1000,
  games_played integer default 0,
  games_won integer default 0,
  last_sign_in_at timestamp,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

-- Otetaan RLS käyttöön
alter table public.profiles enable row level security;

-- Luodaan säännöt: kuka tahansa kirjautunut saa lukea profiileja, mutta vain omaa profiilia saa muokata
create policy "Public profiles are viewable by everyone." on public.profiles
  for select using (true);

create policy "Users can insert their own profile." on public.profiles
  for insert with check (auth.uid() = id);

create policy "Users can update their own profile." on public.profiles
  for update using (auth.uid() = id);

  -- 1. Luo funktio, joka päivittää profiles-taulun tiedot
CREATE OR REPLACE FUNCTION public.handle_user_sign_in()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  UPDATE public.profiles
  SET 
    is_online = TRUE,
    last_sign_in_at = NEW.last_sign_in_at
  WHERE id = NEW.id;
  RETURN NEW;
END;
$$;

-- 2. Luo triggeri, joka laukeaa kun auth.users-taulun tietoja päivitetään
CREATE TRIGGER on_auth_user_updated
  AFTER UPDATE OF last_sign_in_at ON auth.users
  FOR EACH ROW
  WHEN (OLD.last_sign_in_at IS DISTINCT FROM NEW.last_sign_in_at)
  EXECUTE FUNCTION public.handle_user_sign_in();


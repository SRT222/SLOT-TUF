-- TUF Slots global leaderboard. Run once in Supabase: SQL Editor > New query > Run.

create table if not exists public.scores (
  player_id  uuid primary key,
  name       text   not null check (name ~ '^[A-Z]{4}$'),
  best       bigint not null default 0 check (best between 0 and 1000000000),
  updated_at timestamptz not null default now()
);

alter table public.scores enable row level security;

-- Everyone can read names and scores, but never the private player ids.
drop policy if exists "anyone can read scores" on public.scores;
create policy "anyone can read scores" on public.scores for select to anon using (true);
revoke all on public.scores from anon, authenticated;
grant select (name, best, updated_at) on public.scores to anon;

-- The only way to write: a score can rise but never fall, and names must be 4 capital letters.
create or replace function public.submit_score(p_id uuid, p_name text, p_best bigint)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_name !~ '^[A-Z]{4}$' or p_best < 0 or p_best > 1000000000 then
    raise exception 'invalid score';
  end if;
  insert into public.scores (player_id, name, best)
  values (p_id, p_name, p_best)
  on conflict (player_id) do update
    set name = excluded.name,
        best = greatest(public.scores.best, excluded.best),
        updated_at = now();
end;
$$;

revoke all on function public.submit_score(uuid, text, bigint) from public;
grant execute on function public.submit_score(uuid, text, bigint) to anon;

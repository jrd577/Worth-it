create table worthit_data (user_id uuid primary key references auth.users(id) on delete cascade, data jsonb not null, updated_at timestamptz default now());

alter table worthit_data enable row level security;

create policy "own row select" on worthit_data for select using (auth.uid() = user_id);

create policy "own row insert" on worthit_data for insert with check (auth.uid() = user_id);

create policy "own row update" on worthit_data for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

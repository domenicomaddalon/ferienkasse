-- Ferienkasse 1.3 – erste, bewusst unvollständige Schema-Grundlage.
-- Nur für isolierte Entwicklungsumgebung; keine produktive Freigabe.
create extension if not exists pgcrypto;

create table if not exists public.trips (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null references auth.users(id),
 name text not null check (length(name) between 1 and 200),
 trip_date date,
 currency text not null check (currency ~ '^[A-Z]{3}$'),
 budget_cents bigint not null default 0 check (budget_cents >= 0),
 rates jsonb not null default '{}'::jsonb,
 categories jsonb not null default '[]'::jsonb,
 version bigint not null default 1,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);

create table if not exists public.trip_members (
 trip_id uuid not null references public.trips(id) on delete cascade,
 user_id uuid not null references auth.users(id) on delete cascade,
 joined_at timestamptz not null default now(),
 primary key (trip_id,user_id)
);

create or replace function public.is_trip_member(p_trip uuid)
returns boolean language sql stable security definer set search_path = ''
as $$ select exists (
 select 1 from public.trip_members m
 where m.trip_id = p_trip and m.user_id = (select auth.uid())
) or exists (
 select 1 from public.trips t
 where t.id = p_trip and t.owner_id = (select auth.uid())
); $$;

revoke all on function public.is_trip_member(uuid) from public;
grant execute on function public.is_trip_member(uuid) to authenticated;

create table if not exists public.trip_people (
 id uuid primary key default gen_random_uuid(),
 trip_id uuid not null references public.trips(id) on delete cascade,
 name text not null check (length(name) between 1 and 120),
 sort_order integer not null default 0,
 unique (id,trip_id)
);

create table if not exists public.expenses (
 id uuid primary key default gen_random_uuid(),
 trip_id uuid not null references public.trips(id) on delete cascade,
 expense_date date not null,
 name text not null check (length(name) between 1 and 500),
 category text not null,
 payer_id uuid not null,
 currency text not null check (currency ~ '^[A-Z]{3}$'),
 amount_cents bigint not null check (amount_cents > 0),
 rate numeric not null check (rate > 0),
 shares jsonb not null,
 custom_shares jsonb,
 receipt_path text,
 version bigint not null default 1,
 deleted_at timestamptz,
 updated_by uuid references auth.users(id),
 updated_at timestamptz not null default now(),
 unique (id,trip_id),
 foreign key (payer_id,trip_id) references public.trip_people(id,trip_id)
);

create table if not exists public.payments (
 id uuid primary key default gen_random_uuid(),
 trip_id uuid not null references public.trips(id) on delete cascade,
 from_person_id uuid not null,
 to_person_id uuid not null,
 amount_cents bigint not null check (amount_cents > 0),
 paid_date date,
 version bigint not null default 1,
 deleted_at timestamptz,
 foreign key (from_person_id,trip_id) references public.trip_people(id,trip_id),
 foreign key (to_person_id,trip_id) references public.trip_people(id,trip_id)
);

alter table public.trips enable row level security;
alter table public.trip_members enable row level security;
alter table public.trip_people enable row level security;
alter table public.expenses enable row level security;
alter table public.payments enable row level security;

-- Owner may create a trip; all members may read/update it.
create policy trips_select on public.trips for select to authenticated
 using (public.is_trip_member(id));
create policy trips_insert on public.trips for insert to authenticated
 with check (owner_id = (select auth.uid()));
create policy trips_update on public.trips for update to authenticated
 using (public.is_trip_member(id))
 with check (public.is_trip_member(id));

-- Memberships are readable only by members. Creation/deletion requires
-- a future audited invite/owner RPC; no direct client writes are allowed.
create policy members_select on public.trip_members for select to authenticated
 using (public.is_trip_member(trip_id));

create policy people_select on public.trip_people for select to authenticated
 using (public.is_trip_member(trip_id));
create policy people_insert on public.trip_people for insert to authenticated
 with check (public.is_trip_member(trip_id));
create policy people_update on public.trip_people for update to authenticated
 using (public.is_trip_member(trip_id)) with check (public.is_trip_member(trip_id));
create policy people_delete on public.trip_people for delete to authenticated
 using (public.is_trip_member(trip_id));

create policy expenses_select on public.expenses for select to authenticated
 using (public.is_trip_member(trip_id));
create policy expenses_insert on public.expenses for insert to authenticated
 with check (public.is_trip_member(trip_id) and updated_by = (select auth.uid()));
create policy expenses_update on public.expenses for update to authenticated
 using (public.is_trip_member(trip_id)) with check (public.is_trip_member(trip_id));
create policy expenses_delete on public.expenses for delete to authenticated
 using (public.is_trip_member(trip_id));

create policy payments_select on public.payments for select to authenticated
 using (public.is_trip_member(trip_id));
create policy payments_insert on public.payments for insert to authenticated
 with check (public.is_trip_member(trip_id));
create policy payments_update on public.payments for update to authenticated
 using (public.is_trip_member(trip_id)) with check (public.is_trip_member(trip_id));
create policy payments_delete on public.payments for delete to authenticated
 using (public.is_trip_member(trip_id));

-- TODO before pilot: member onboarding RPC, conflict-safe mutation RPCs,
-- prevent trip owner/trip_id reassignment, membership lifecycle,
-- receipt Storage RLS, audit triggers, grants review, quota controls.

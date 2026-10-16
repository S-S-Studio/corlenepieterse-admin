create extension if not exists pgcrypto;
create table if not exists public.categories(id text primary key,name text not null,visible boolean not null default true,sort_order integer not null default 0);
create table if not exists public.paintings(id text primary key,title text not null default '',category_id text not null references public.categories(id),price text not null default '',status text not null check(status in ('for-sale','previous')),description text not null default '',dimensions text not null default '',medium text not null default '',image_url text not null,image_path text,sort_order integer not null default 0,created_at timestamptz not null default now(),updated_at timestamptz not null default now());
create table if not exists public.news_items(id text primary key,slug text not null unique,title text not null,content text not null default '',visible boolean not null default true,image_url text,image_path text,created_at timestamptz not null default now(),updated_at timestamptz not null default now());
create table if not exists public.site_settings(id integer primary key check(id=1),artist_name text not null default '',location text not null default '',about_intro text not null default '',about_full text not null default '',hero_image_url text,hero_image_path text,whatsapp text not null default '',email text not null default '',facebook_url text not null default '',updated_at timestamptz not null default now());
create or replace function public.set_updated_at() returns trigger language plpgsql as $$begin new.updated_at=now();return new;end$$;
drop trigger if exists paintings_updated_at on public.paintings;create trigger paintings_updated_at before update on public.paintings for each row execute function public.set_updated_at();
drop trigger if exists news_updated_at on public.news_items;create trigger news_updated_at before update on public.news_items for each row execute function public.set_updated_at();
drop trigger if exists settings_updated_at on public.site_settings;create trigger settings_updated_at before update on public.site_settings for each row execute function public.set_updated_at();
insert into public.categories values ('wildlife','Wildlife',true,10),('farm-animals','Farm Animals',true,20),('nature','Nature',true,30),('portrait','Portrait',true,40),('other','Other',true,50) on conflict(id) do update set name=excluded.name,visible=excluded.visible,sort_order=excluded.sort_order;
insert into public.paintings(id,title,category_id,price,status,description,dimensions,medium,image_url,image_path,sort_order) values
('1','Oudste siel','nature','R10 500','for-sale','','70 × 100 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/oudste-siel.jpeg',NULL,1),
('2','Quiet King','wildlife','R7 300','for-sale','','70 × 60 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/quiet-king.jpeg',NULL,2),
('3','Ongewankel','farm-animals','R10 500','for-sale','','70 × 100 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/ongewankel.jpeg',NULL,3),
('4','Stormloop','farm-animals','R18 000','for-sale','','100 × 120 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/stormloop.jpeg',NULL,4),
('5','Circle of Belonging','farm-animals','R11 800','for-sale','','100 cm diameter','Oil on Wood Board','https://corlenepieterse.co.za/assets/images/circle-of-belonging.jpeg',NULL,5),
('6','Genoeg','farm-animals','R900','for-sale','','20 × 30 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/genoeg.jpeg',NULL,6),
('7','Bly naby','farm-animals','R900','for-sale','','20 × 30 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/bly-naby.jpeg',NULL,7),
('8','Die Komitee','farm-animals','R1 900','for-sale','','30 × 42 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/die-komitee.jpeg',NULL,8),
('9','Sonneblom kind 1','portrait','R1 800','for-sale','','40 × 30 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/sonneblom-kind-1.jpeg',NULL,9),
('10','Sonneblom kind 2','portrait','R1 800','for-sale','','40 × 30 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/sonneblom-kind-2.jpeg',NULL,10),
('11','Kinder liefde - rooi stewels','portrait','R1 800','for-sale','','30 × 40 cm','Oil on Stretched Canvas','https://corlenepieterse.co.za/assets/images/kinder-liefde-rooi-stewels.jpeg',NULL,11),
('100','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-01-human.jpeg',NULL,100),
('101','','farm-animals','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-02-farm-animals.jpeg',NULL,101),
('102','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-03-human.jpeg',NULL,102),
('103','','nature','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-04-nature.jpeg',NULL,103),
('104','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-05-wildlife.jpeg',NULL,104),
('105','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-06-human.jpeg',NULL,105),
('106','','farm-animals','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-07-farm-animals.jpeg',NULL,106),
('107','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-08-wildlife.jpeg',NULL,107),
('108','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-09-wildlife.jpeg',NULL,108),
('109','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-10-human.jpeg',NULL,109),
('110','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-11-wildlife.jpeg',NULL,110),
('111','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-12-human.jpeg',NULL,111),
('112','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-13-wildlife.jpeg',NULL,112),
('113','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-14-wildlife.jpeg',NULL,113),
('114','','farm-animals','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-15-farm-animals.jpeg',NULL,114),
('115','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-16-human.jpeg',NULL,115),
('116','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-17-human.jpeg',NULL,116),
('117','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-18-wildlife.jpeg',NULL,117),
('118','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-19-human.jpeg',NULL,118),
('119','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-20-wildlife.jpeg',NULL,119),
('120','','portrait','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-21-human.jpeg',NULL,120),
('121','','wildlife','','previous','','','','https://corlenepieterse.co.za/assets/images/previous-22-wildlife.jpeg',NULL,121)
on conflict(id) do update set title=excluded.title,category_id=excluded.category_id,price=excluded.price,status=excluded.status,description=excluded.description,dimensions=excluded.dimensions,medium=excluded.medium,image_url=excluded.image_url,sort_order=excluded.sort_order;
insert into public.news_items(id,slug,title,content,visible,image_url,image_path) values('news-nampo-alfa-2026','nampo-alfa-2026','Come Visit My Art Exhibition at NAMPO ALFA 2026','I will be showing and selling my original paintings, including realistic wildlife, cattle and farm life.

Venue: NAMPO Park, Bothaville
Hopefield Hall — No. 13
Dates: 2–3 October 2026

Original oil paintings will be on display. Commissions are welcome — I paint anything on request.

Bring the family and come say hello. I would love to see you there!

Corléne Pieterse',true,'https://corlenepieterse.co.za/assets/images/nampo-alfa-2026.jpeg',null) on conflict(id) do update set slug=excluded.slug,title=excluded.title,content=excluded.content,visible=excluded.visible,image_url=excluded.image_url;
insert into public.site_settings(id,artist_name,location,about_intro,about_full,hero_image_url,hero_image_path,whatsapp,email,facebook_url) values(1,'Corléne Pieterse','North West, South Africa','I’m Corléne Pieterse, a self-taught painter from North West, South Africa.','I have been painting for 22 years. I never studied art — I learned by watching. Watching how dust hangs in the air after cattle cross a road, how the grass in a field holds many colours and textures, how light and shadow change at 5pm, and how everything comes together to bring realism to a painting.

That is what I try to paint: not just an object, but its presence. Its character.

My passion is realistic wildlife and portrait paintings in oil, but over the years I have learned to say yes to almost anything — if it has meaning for you, I will paint it. From a beloved dog, to your grandmother’s farmhouse, to anything beautiful you want to bring into your home.

Growing up on a farm taught me that nature is not separate from us. It belongs in our homes. My goal is to bring a piece of our beautiful world — its strength, its silence, its wildness — onto your wall.

All works are original oils. Commissions and custom sizes are welcome.','https://corlenepieterse.co.za/assets/images/corlene-pieterse-hero.jpeg',null,'27712170470','art@corlenepieterse.co.za','https://www.facebook.com/share/1Ef3QSD8dy/?mibextid=wwXIfr') on conflict(id) do update set artist_name=excluded.artist_name,location=excluded.location,about_intro=excluded.about_intro,about_full=excluded.about_full,hero_image_url=excluded.hero_image_url,whatsapp=excluded.whatsapp,email=excluded.email,facebook_url=excluded.facebook_url;
alter table public.categories enable row level security;alter table public.paintings enable row level security;alter table public.news_items enable row level security;alter table public.site_settings enable row level security;
drop policy if exists "public read categories" on public.categories;create policy "public read categories" on public.categories for select using(visible=true);
drop policy if exists "public read paintings" on public.paintings;create policy "public read paintings" on public.paintings for select using(true);
drop policy if exists "public read visible news" on public.news_items;create policy "public read visible news" on public.news_items for select using(visible=true);
drop policy if exists "public read settings" on public.site_settings;create policy "public read settings" on public.site_settings for select using(true);
drop policy if exists "authenticated manage categories" on public.categories;create policy "authenticated manage categories" on public.categories for all to authenticated using(true) with check(true);
drop policy if exists "authenticated manage paintings" on public.paintings;create policy "authenticated manage paintings" on public.paintings for all to authenticated using(true) with check(true);
drop policy if exists "authenticated manage news" on public.news_items;create policy "authenticated manage news" on public.news_items for all to authenticated using(true) with check(true);
drop policy if exists "authenticated manage settings" on public.site_settings;create policy "authenticated manage settings" on public.site_settings for all to authenticated using(true) with check(true);
insert into storage.buckets(id,name,public) values('paintings','paintings',true),('site-media','site-media',true) on conflict(id) do update set public=excluded.public;
drop policy if exists "public read website media" on storage.objects;create policy "public read website media" on storage.objects for select using(bucket_id in('paintings','site-media'));
drop policy if exists "authenticated upload website media" on storage.objects;create policy "authenticated upload website media" on storage.objects for insert to authenticated with check(bucket_id in('paintings','site-media'));
drop policy if exists "authenticated update website media" on storage.objects;create policy "authenticated update website media" on storage.objects for update to authenticated using(bucket_id in('paintings','site-media')) with check(bucket_id in('paintings','site-media'));
drop policy if exists "authenticated delete website media" on storage.objects;create policy "authenticated delete website media" on storage.objects for delete to authenticated using(bucket_id in('paintings','site-media'));

-- Multi-photo news support (Admin V006)

--finding the distinct 
select distinct Name from [dbo].[videogamesales]
select distinct Platform from [dbo].[videogamesales]
select distinct Genre from [dbo].[videogamesales]
select distinct Publisher from [dbo].[videogamesales]

--add foreign key in videogamesalesvalue
ALTER TABLE videogamesalesvalue
add foreign key(game_id) references game(id)
ALTER TABLE videogamesalesvalue
add foreign key(platform_id) references platform(id)
ALTER TABLE videogamesalesvalue
add foreign key(genre_id) references genre(id)
ALTER TABLE videogamesalesvalue
add foreign key(publisher_id) references publisher(id)

--add foreign key in videogamesrating
ALTER TABLE videogamesrating
add foreign key(game_id) references game(id)
ALTER TABLE videogamesrating
add foreign key(platform_id) references platform(id)
ALTER TABLE videogamesrating
add foreign key(genre_id) references genre(id)
ALTER TABLE videogamesrating
add foreign key(publisher_id) references publisher(id)

select count(distinct Game_Name) as 'No of Games' from videogamesalesvalue
where Year_of_Release between 2006 and 2017 

select year_of_release, count(*) as 'No of Games',  Round(sum(Average_Sales_Per_Year),2) as 'Global Sales' from videogamesalesvalue
where year_of_release is not null
group by year_of_release
order by year_of_release;

select pl.Platform_Name, count(*) as 'No of Games', Round(sum(vgid.Global_sales),2) as 'Global Sales' from videogamesalesvalue vgid
inner join Platform pl
on pl.id = vgid.Platform_ID
where vgid.Year_of_Release between 2006 and 2017
group by pl.Platform_Name
order by sum(vgid.Global_sales) desc;

select G.Genre_Type, count(*) as 'No of Games', Round(sum(vgid.Global_sales),2) as 'Global Sales' from videogamesalesvalue vgid
inner join Genre G
on g.id = vgid.Genre_ID
where vgid.Year_of_Release between 2006 and 2017
group by G.Genre_Type
order by sum(vgid.Global_sales) desc;

--------------------------------------
select top 10 g.Game_Name, ge.Genre_Type, round(sum(vgid.Average_Sales_Per_Year),2) as 'Sum of Global Sales per year' from videogamesalesvalue vgid
inner join game g
on g.id=vgid.game_id
inner join Genre Ge
on ge.id=vgid.Genre_ID
where vgid.Year_of_Release between 2006 and 2017
group by g.Game_Name, ge.Genre_Type
order by sum(vgid.Average_Sales_Per_Year) desc

select top 10 g.Game_Name, ge.Genre_Type, round(avg(vgr.user_score),2) as 'Avg User Score' from videogamesrating vgr
inner join game g
on g.id=vgr.game_id
inner join Genre Ge
on ge.id=vgr.Genre_ID
where vgr.Year_of_Release between 2006 and 2017 and user_count>1000
group by g.Game_Name, ge.Genre_Type
order by avg(vgr.user_score) desc

select top 10 g.Game_Name, ge.Genre_Type, avg(vgr.Critic_Score) as 'Avg Critic Score' from videogamesrating vgr
inner join game g
on g.id=vgr.game_id
inner join Genre Ge
on ge.id=vgr.Genre_ID
where vgr.Year_of_Release between 2006 and 2017 and critic_count>70
group by g.Game_Name, ge.Genre_Type
order by avg(vgr.Critic_Score) desc
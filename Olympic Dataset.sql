create database olympic;
use olympic;

create table athelete_events(
ID	int,
`Name` varchar(300),
Sex varchar(300),
Age varchar(300),
Height varchar(300),
Weight varchar(300),
Team varchar(300),
NOC	varchar(300),
Games varchar(300),
`Year` varchar(300),
Season varchar(300),
City varchar(300),
Sport varchar(300),
`Event` varchar(300),
Medal varchar(300));


load data infile
'd:/athlete_events.csv'
into table athelete_events
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from athelete_events;

create table noc_regions(
`noc`	varchar(300),
region	varchar(300),
notes varchar(300));

load data infile
'd:/noc_regions.csv'
into table noc_regions
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from noc_regions;
select * from athelete_events;

#How many olympics games have been held
select  count(distinct(games)) from athelete_events;

#List down all Olympics games held so far.
select distinct(games), year, city from athelete_events;

#Mention the total no of nations who participated in each olympics game.
select `year`, count(distinct(NOC)), games from athelete_events group by games;

#Which year saw the highest and lowest no of countries participating in olympics.
select year, count(distinct(noc)) from athelete_events  group by `year` order by count(distinct(noc)) desc;
select `year`, count(distinct(noc)) from athelete_events group by `year` order by count(distinct(noc));
#or
create view sample5 as select year, count(distinct(noc)) from athelete_events  
group by `year` order by count(distinct(noc)) desc;
select max(`count(distinct(noc))`), year from sample5;

create view sample6 as select `year`, count(distinct(noc)) from athelete_events 
group by `year` order by count(distinct(noc));
select min(`count(distinct(noc))`), year from sample5;

#Which nation has participated in all of the olympic games.
select count(distinct(games)) from athelete_events;
create view sample as select distinct(team), games, year from athelete_events;
create view sample1 as select count(team), team, year, games from sample group by team order by count(team) desc;
select * from sample1 where `count(team)` = 51;

#Identify the sport which was played in all summer olympics.
select count(distinct(games)) from athelete_events where games like '%summer%' ;
create view sample4 as select distinct(sport), games from athelete_events where games like '%summer%' group by games ;
select count(sport) from sample4 group by sport;

#Which Sports were just played only once in the olympics-7
create view spots as select sport, games from athelete_events group by sport order by games;
select count(sport), sport , games from spots group by sport  ;


#Fetch the total no of sports played in each olympic games.
select count(distinct(sport)), games from athelete_events group by games;


#Fetch details of the oldest athletes to win a gold medal.
select * from athelete_events where medal = 'gold' and age != 'NA' order by age desc;
select * from athelete_events where medal = 'gold' and age = 64 ;

#Find the Ratio of male and female athletes participated in all olympic games.
select (count(sex)) from athelete_events where sex = 'm';
select (count(sex)) from athelete_events where sex = 'F';


#Fetch the top 5 athletes who have won the most gold medals.
select count(medal), name from athelete_events 
where medal = 'gold' group by `name` order by count(medal) desc limit 5 ;

#Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
select `name`, count(medal), team from athelete_events 
where medal != 'NA' group by `name` order by count(medal) desc limit 5;


#Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select team, count(medal) from athelete_events 
where medal != 'NA' group by team order by count(medal) desc limit 5;


#List down total gold, silver and broze medals won by each country.
select count(medal) as 'silver', team from athelete_events where medal = 'silver' group by team;
select count(medal), medal, team from athelete_events where medal = 'bronze' group by team;
select count(medal), medal, team from athelete_events where medal = 'gold' group by team;
#cross join to concatinate in one table


#List down total gold, silver and broze medals won by each country corresponding to each olympic games.
select count(medal), medal, team, games from athelete_events where medal = 'gold' group by team and games;
#Identify which country won the most gold, most silver and most bronze medals in each olympic games.
#Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.


#Which countries have never won gold medal but have won silver/bronze medals.
select count(medal) as silver, team from athelete_events 
where medal != 'gold' and medal != 'NA' and medal ='silver' group by team;

select count(medal) as bronze, team from athelete_events 
where medal != 'gold' and medal != 'NA' and medal ='bronze' group by team;
#Cross join after creating view to concatinate in single table


#In which Sport/event, India has won highest medals.
select count(medal), team, sport from athelete_events 
where team = 'india' and medal != 'na' group by sport order by count(medal) desc; 


#Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
select count(medal), games , sport, team from athelete_events 
where sport = 'hockey' and team = 'india' and medal != 'na' group by games;


-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select bidder_id,count(bidder_id)no_of_bids,count(case when bid_status='won' then bidder_id end )no_of_wins,
round(count(case when bid_status='won' then bidder_id end)/count(bidder_id)*100,2) percentage_of_wins from ipl_bidding_details
group by bidder_id order by percentage_of_wins desc;

-- 2.	Display the number of matches conducted at each stadium with the stadium name and city.
select t1.stadium_id,stadium_name,city,count(t1.stadium_id)no_of_matches from ipl_stadium t1 join ipl_match_schedule t2 
on t1.stadium_id=t2.stadium_id group by t1.stadium_id order by t1.stadium_id;

-- 3.	In a given stadium, what is the percentage of wins by a team that has won the toss?
select stadium_id,count(stadium_id)no_of_matches,count(case when match_winner=toss_winner then stadium_id end)no_of_matches_won_by_toss_winning_team,
count(case when match_winner=toss_winner then stadium_id end)/count(stadium_id)*100 percentage_of_wins from ipl_match_schedule ims join ipl_match im on im.match_id=ims.match_id 
 where status='completed'group by stadium_id;

-- 4.	Show the total bids along with the bid team and team name.
select bid_team,team_name,count(bid_team) from ipl_bidding_details ibd join ipl_team it on ibd.bid_team=it.TEAM_ID group by bid_team order by count(bid_team) desc;

-- 5.	Show the team ID who won the match as per the win details.
select *,case when match_winner=1 then team_id1 else team_id2 end as winning_team_id from ipl_match;


-- 6.	Display the total matches played, total matches won and total matches lost by the team along with its team name
with t as(with temp as(select *,(case when match_winner=1 then team_id1 else team_id2 end)match_winner_id from ipl_match)
select team_id1,count(team_id1)no_of_matches,count(case when team_id1=match_winner_id then team_id1 end)no_of_wins,count(team_id1)-count(case when team_id1=match_winner_id then team_id1 end)no_of_losses from temp group by team_id1)
select team_name,no_of_matches,no_of_wins,no_of_losses from t join ipl_team it on t.team_id1=it.team_id;

-- 7.	Display the bowlers for the Mumbai Indians team.
select player_name from ipl_team_players itp join ipl_player ip on itp.player_id=ip.player_id where player_role='Bowler' and 
itp.REMARKS like '%MI%';

-- 8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounders in descending order.

with temp as(select remarks,count(player_id)`no_of_all-rounders` from ipl_team_players where player_role='all-rounder' group by remarks order by count(player_id)desc)
select * from temp where `no_of_all-rounders`>4;

-- 9.	 Write a query to get the total bidders' points for each bidding status of those bidders who bid on CSK when they won the match in M. Chinnaswamy Stadium bidding year-wise.
 -- Note the total bidders’ points in descending order and the year is the bidding year.
             --   Display columns: bidding status, bid date as year, total bidder’s points
select bid_status,ibp.TOURNMT_ID,total_points from ipl_bidder_points ibp join ipl_bidding_details ibd on ibp.bidder_id=ibd.BIDDER_ID 
join ipl_match_schedule ims on ims.SCHEDULE_ID=ibd.SCHEDULE_ID join ipl_match im on im.match_id=ims.MATCH_ID where STADIUM_ID=
(select stadium_id from ipl_stadium where STADIUM_NAME like '%chinnaswamy%') and 
bid_team=(select team_id from ipl_team where team_name like '%chennai%') and win_details like '%Team CSK WON BY%' order by total_points desc;

-- 10.	Extract the Bowlers and All-Rounders that are in the 5 highest number of wickets.
-- Note 
-- 1. Use the performance_dtls column from ipl_player to get the total number of wickets
-- 2. Do not use the limit method because it might not give appropriate results when players have the same number of wickets
-- 3. Do not use joins in any cases.
-- 4. Display the following columns teamn_name, player_name, and player_role.
with t as(with temp as(select *,cast(substring_index(substring_index(performance_dtls,'Wkt-',-1)," ",1) as Signed)as wickets from ipl_player
where player_id in (select player_id from ipl_team_players where player_role in('bowler','all-rounder')))
select *,dense_rank()over(order by wickets desc)rnk from temp)
select t.player_name,itp.PLAYER_ROLE,itp.REMARKS from t,ipl_team_players itp where t.PLAYER_ID = itp.PLAYER_ID and t.rnk<=5;

-- 11.	show the percentage of toss wins of each bidder and display the results in descending order based on the percentage
with temp as(select bidder_id,BID_TEAM,TEAM_ID1,TEAM_ID2,TOSS_WINNER,case when toss_winner=1 then team_id1 else TEAM_ID2 end toss_winner_id from ipl_bidding_details ibd join ipl_match_schedule ims on ibd.SCHEDULE_ID=ims.SCHEDULE_ID join ipl_match im on 
im.MATCH_ID=ims.MATCH_ID)
select ibd.bidder_id,bidder_name,count(ibd.bidder_id)no_of_bids,count(case when bid_team=toss_winner_id then ibd.bidder_id end)no_of_toss_wins,
count(case when bid_team=toss_winner_id then ibd.bidder_id end)/count(ibd.bidder_id)*100 as percentage_of_toss_wins 
 from temp join ipl_bidder_details ibd on temp.bidder_id=ibd.BIDDER_ID group by bidder_id order by percentage_of_toss_wins desc;


-- 12.	find the IPL season which has a duration and max duration.
--      Output columns should be like the below:
 --     Tournment_ID, Tourment_name, Duration column, Duration
with temp as(select tournmt_id,tournmt_name,datediff(to_date,from_Date)duration_in_days,
 dense_rank() over(order by datediff(to_date,from_Date) desc)rnk from ipl_tournament)
 select tournmt_id,tournmt_name,duration_in_days from temp where rnk=1;
 
 -- 13.	Write a query to display to calculate the total points month-wise for the 2017 bid year. sort the results based on total points in descending order and month-wise in ascending order.
-- Note: Display the following columns:
-- 1.	Bidder ID, 2. Bidder Name, 3. Bid date as Year, 4. Bid date as Month, 5. Total points
-- Only use joins for the above query queries.

select distinct ibd.bidder_id,total_points,bidder_name,month(BID_DATE),year(BID_DATE) from ipl_bidding_details ibd join ipl_bidder_details ib on ibd.BIDDER_ID=ib.BIDDER_ID
join ipl_bidder_points ibp on ibp.BIDDER_ID=ibd.BIDDER_ID where year(bid_date)=2017 order by total_points desc,month(bid_date);

-- 14.	Write a query for the above question using sub-queries by having the same constraints as the above question.
select distinct bidder_id,(select bidder_name from ipl_bidder_details where ipl_bidder_details.BIDDER_ID=ipl_bidding_details.BIDDER_ID)bidder_name,
(select total_points from ipl_bidder_points where ipl_bidder_points.BIDDER_ID=ipl_bidding_details.BIDDER_ID)total_points,month(bid_date),
year(bid_date) from ipl_bidding_details where year(bid_date)=2017 order by total_points desc,month(bid_date);

-- 15.	Write a query to get the top 3 and bottom 3 bidders based on the total bidding points for the 2018 bidding year.
-- Output columns should be:like
-- Bidder Id, Ranks (optional), Total points, Highest_3_Bidders --> columns contains name of bidder, Lowest_3_Bidders  --> columns contains name of bidder;

with temp as (select ibd.bidder_id,total_points,bidder_name,rank() over(order by total_points desc)drnk,
rank() over(order by total_points)rnk from ipl_bidder_points ibp join ipl_bidder_details ibd on ibp.BIDDER_ID=ibd.bidder_id)
select bidder_id,total_points,case when drnk<=3 then bidder_name end as highest_3,case when rnk<=3 then bidder_name end as lowest_3 
from temp where rnk<=3 or drnk<=3;


 




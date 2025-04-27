# IPL-Pie-in-the-sky-DBMS-Project
Insights of IPL match to allow the user to bid.
Pie-in-the-Sky is a mobile app that is used for bidding for IPL matches legally. Any registered user can bid for any of the IPL matches listed in it. New users or bidders need to register themselves into the app by providing their mobile phone number, email id, and password. Admin will maintain the match roster and keep updating other details in the system.
The app shows the match details which include the playing team, the venue of the match, and the current standing of the teams on the points table. It will display the winner at the end of the match and update the team standings in the tournament and bidder points table. System will send updates to the bidders whenever required. It will also generate the bidders' leaderboard.
App functionalities:
●	Predict Winner
The app allows the user to predict the winner of the match before the toss happens for the match on which the user is predicting. This is dynamic as the matches can have a different start time. Start time will also be influenced by disruptions like rains and other unforeseen circumstances. Users will not be able to see what others have predicted. Users can change the team bids only till the toss happens. Once the toss happens everything freezes for that match.
●	Point System
For every win, users get points. There are no negative points, meaning if the user loses the bid, he or she does not lose his/her points. The Point system is very dynamic. 
At the start of the tournament when every team is at zero points, every user who wins the prediction wins 2 points.
If the difference in the points between two teams playing, is <= 6, but > 0, then the person who predicts: 
-	Team with higher points will win, gets 2 points 
-	Team with lower points will win, gets 3 points
If the difference in the points between two teams playing is > 6, then the person who predicts: 
-	Team with higher points will win, gets 2 points 
-	Team with lower points will win, gets 5 points

●	Leaderboard
At every time the user will be able to see his/her points and his/her position in the overall user standings. He/she will also be able to see the top 3 leader positions

A bidder can do the following things using this app:
●	can see all the match schedules (teams, date & time of the match, location). 
●	bid on a team for a match before the start of the match 
●	can predict the match winner only till its toss occurs (Note that match start time might change due to weather conditions)
●	can bid for any number of matches
●	after bidding on a team, (s)he would be able to change his/her team before the match starts
●	bidding cannot be changed once the respective match starts
●	can cancel the bid on a match; will not lose any points
●	At any time, the bidder will be able to see his/her points and his/her position in the overall bidder standings. 
●	can see top 3 leader positions
●	can see team standings anytime (i.e. their points tally)
●	cannot see any details of other bidders

Admin can do the following activities:
●	manage tournament (tournament id, duration, description)
●	manage teams (description of players and team)
●	schedule and reschedule matches. Each team will play only once with the remaining teams
●	edit details of match and stadium
●	update match statistics (date and match result of all the earlier matches)
●	declare the result of the match along with their scores
●	declare winner and loser along with their points
●	update team statistics (team and player performance)
●	update overview at the end of the match
●	view all the bidders bidding on a particular team and the %age of users supporting a team





A few Questions have been provided to solve.



Questions – Write SQL queries to get data for the following requirements:

1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.

2.	Display the number of matches conducted at each stadium with the stadium name and city.

3.	In a given stadium, what is the percentage of wins by a team that has won the toss?

4.	Show the total bids along with the bid team and team name.

5.	Show the team ID who won the match as per the win details.

6.	Display the total matches played, total matches won and total matches lost by the team along with its team name.

7.	Display the bowlers for the Mumbai Indians team.

8.	How many all-rounders are there in each team, Display the teams with more than 4 
all-rounders in descending order.


9.	 Write a query to get the total bidders' points for each bidding status of those bidders who bid on CSK when they won the match in M. Chinnaswamy Stadium bidding year-wise.
 Note the total bidders’ points in descending order and the year is the bidding year.
               Display columns: bidding status, bid date as year, total bidder’s points

10.	Extract the Bowlers and All-Rounders that are in the 5 highest number of wickets.
Note 
1. Use the performance_dtls column from ipl_player to get the total number of wickets
 2. Do not use the limit method because it might not give appropriate results when players have the same number of wickets
3.	Do not use joins in any cases.
4.	Display the following columns teamn_name, player_name, and player_role.

11.	show the percentage of toss wins of each bidder and display the results in descending order based on the percentage

12.	find the IPL season which has a duration and max duration.
Output columns should be like the below:
 Tournment_ID, Tourment_name, Duration column, Duration

13.	Write a query to display to calculate the total points month-wise for the 2017 bid year. sort the results based on total points in descending order and month-wise in ascending order.
Note: Display the following columns:
1.	Bidder ID, 2. Bidder Name, 3. Bid date as Year, 4. Bid date as Month, 5. Total points
Only use joins for the above query queries.

14.	Write a query for the above question using sub-queries by having the same constraints as the above question.

15.	Write a query to get the top 3 and bottom 3 bidders based on the total bidding points for the 2018 bidding year.
Output columns should be:
like
Bidder Id, Ranks (optional), Total points, Highest_3_Bidders --> columns contains name of bidder, Lowest_3_Bidders  --> columns contains name of bidder;

16.	Create two tables called Student_details and Student_details_backup. (Additional Question - Self Study is required)

Table 1: Attributes 		Table 2: Attributes
Student id, Student name, mail id, mobile no.	Student id, student name, mail id, mobile no.

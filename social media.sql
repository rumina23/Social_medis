USE social_media_analyst;


SELECT username, count(follower_user_id) as follower_count from users 
JOIN followers ON user_id =  follower_user_id
GROUP BY username
ORDER BY follower_count desc;

## most liked post

SELECT p.post_id, p.content, Count(l.like_id) as like_count
FROM posts p
JOIN likes l ON post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY like_count DESC
LIMIT 3;

### post, commenets, likes

SELECT u.username,
	COUNT(distinct p.post_id) AS total_post,
    COUNT(distinct c.comment_id) AS totals_comments,
    COUNT(distinct l.like_id) AS total_likes
FROM users u 
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN comments c ON u.user_ID = c.user_id
LEFT JOIN likes l ON u.user_id = l.user_id
Group BY u.username;

### Post-to-Like Ratio: Create a report that shows the post-to-like ratio for each user.

SELECT u.username,
	COUNT(p.post_id) AS total_posts,
    COUNT(l.like_id) AS total_likes,
	CASE
		WHEN COUNT(p.post_id)= 0 THEN 0
        ELSE CAST(COUNT(l.like_id) as DECIMAL) / COUNT(p.post_id)
	END AS post_to_like_ratio
   FROM users u
   LEFT JOIN posts p ON u.user_id = p.user_id
   LEFT JOIN likes l ON p.post_id = l.post_id
   GROUP BY u.username;
   
####Inactive Users: List users who haven’t posted anything in the last 30 days.

SELECT u.username 
from users u
left JOIN posts p ON u.user_id = p.user_id
WHERE p.created_at < curdate() - INTERVAL 30 DAY
	OR p.created_at IS NULL;
    
    ###Retrieve all users who signed up in the last 6 months:
SELECT *
FROM users
WHERE created_at >= CURRENT_DATE() - INTERVAL 6 MONTH;

###Retrieve posts with more than 5 likes
SELECT p.post_id, p.content
from posts p
where (SELECT count(*)
	from likes l
	where l.post_id = p.post_id)>5;
    
    ###Find the top 5 most recent posts
    
SELECT post_id, content, created_at
from posts
ORDER BY created_at DESC
LIMIT 5;

###Posts and Comments:  Display all posts with the corresponding comments.
#### Include post_id, content, and the text of the comment, even if there are no comments on a post (use a left join)
SELECT p.post_id, p.content, c.comment
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id;

####User Follower Relationship: Write a query that shows each user and the number of followers they have. 
###Sort the list by the number of followers in descending order
SELECT u.username, COUNT(f.follower_user_id) AS follower_count
FROM users u
LEFT JOIN followers f ON u.user_id = f.followed_user_id
GROUP BY u.username
ORDER BY follower_count DESC;


    
    
    
    
    
    
    


   
   




    






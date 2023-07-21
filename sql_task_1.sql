SELECT users.name AS username, communities.name AS communityname, community_members.joined_at
FROM community_members, users, communities
WHERE community_members.user_id = users.id
  AND community_members.community_id = communities.id
  AND community_members.joined_at >= '2013-01-01 00:00:00'
ORDER BY community_members.joined_at
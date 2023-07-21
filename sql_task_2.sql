SELECT community_id, community_name, perm_name, count_users
FROM (
         SELECT perm_id, perm_name, member_id, name AS user_name, community_id, community_name, COUNT(name) AS count_users
         FROM
             (
                 SELECT permissions.id AS perm_id, permissions.name AS perm_name, member_id
                 FROM permissions, community_member_permissions
                 WHERE community_member_permissions.permission_id = permissions.id
             ) AS permission_by_member_name,
             (
                 SELECT usr_name_by_member.id, usr_name_by_member.name, usr_name_by_member.community_id, communities.name as community_name
                 FROM
                     (
                         SELECT community_members.id, name, community_id
                         FROM community_members, users
                         WHERE community_members.user_id = users.id
                     ) as usr_name_by_member, communities
                 WHERE communities.id = usr_name_by_member.community_id
             ) AS user_name_by_members_and_communities
         WHERE user_name_by_members_and_communities.id = permission_by_member_name.member_id
         GROUP BY community_id, perm_id
     ) AS result WHERE count_users >= 5
ORDER BY community_id DESC, count_users
LIMIT 100
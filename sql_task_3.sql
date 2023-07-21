SELECT userinf.username, userinf.communityname, permissionname
FROM
    (
        SELECT permissions.name AS permissionname, community_member_permissions.member_id
        FROM community_member_permissions, permissions
        WHERE community_member_permissions.permission_id = permissions.id
    ) AS perm,
    (
        SELECT community_members.id, users.name AS username, communities.name AS communityname
        FROM community_members, users, communities
        WHERE community_members.user_id = users.id
          AND community_members.community_id = communities.id
          AND LENGTH(communities.name) >= 15
    ) AS userinf
WHERE
    (UPPER(userinf.communityname) LIKE '%T%' OR
     permissionname LIKE 'articles') AND
        perm.member_id = userinf.id
ORDER BY username
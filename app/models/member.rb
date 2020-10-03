class Member < ApplicationRecord
  def friendships
    Friendship.where('member_id = ? OR friend_id = ?', id, id)
  end

  def friends
    records = friendships
    friend_ids = records.map(&:friend_id).concat(records.map(&:member_id))
    Member.find(friend_ids - [id])
  end
end

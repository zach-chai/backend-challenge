class Member < ApplicationRecord
  def friends
    friendships = Friendship.where('member_id = ? OR friend_id = ?', id, id)
    friend_ids = friendships.map(&:friend_id).concat(friendships.map(&:member_id))
    friend_ids.delete(id)
    Member.find(friend_ids)
  end
end

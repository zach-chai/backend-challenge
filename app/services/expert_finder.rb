class ExpertFinder
  def initialize(member, topic)
    @member = member
    @topic = topic
    @path = {}
    @found_path = false
  end

  def find_expert
    experts = fetch_experts
    expert = calculate_path(experts)
    get_path(expert)
  end

  private

  def fetch_experts
    # TODO fix slow query
    Member.where.not(id: [@member.id] + @member.friends.map(&:id))
          .where("array_to_string(keywords, '||') ILIKE :topic", topic: "%#{@topic}%")
  end

  def calculate_path(experts)
    members = [@member]
    visited = Set.new(members)

    while members.length > 0 do
      current = members.shift
      current.friends.each do |friend|
        next if visited.include?(friend)

        members.push(friend)
        visited.add(friend)
        @path[friend] = current

        if experts.include? friend
          @found_path = true
          return friend
        end
      end
    end
  end

  def get_path(expert)
    return unless @found_path

    member = expert
    path = [member]

    while member != @member do
      member = @path[member]
      path.push(member)
    end
    puts path
    path
  end
end

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy, :find_experts]

  # GET /members
  def index
    @members = Member.all
    response = @members.map do |member|
      {
        name: member.name,
        website: member.website,
        friends: member.friends.length
      }
    end

    render json: response
  end

  # GET /members/1
  def show
    render json: {
      name: @member.name,
      website: @member.website,
      friends: @member.friends.map { |friend| url_for(friend) },
      keywords: @member.keywords
    }
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    scraper = WebScraper.new @member.website
    @member.keywords = scraper.scrape

    if @member.save
      render json: @member, status: :created, location: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      render json: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
  end

  def find_experts
    expert_finder = ExpertFinder.new(@member, params[:topic])
    expert_path = expert_finder.find_expert || []
    result = expert_path.map do |member|
      { name: member.name, profile: url_for(member) }
    end
    render json: {
      path: result
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:name, :website)
    end
end

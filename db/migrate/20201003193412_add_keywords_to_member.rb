class AddKeywordsToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :keywords, :string, array: true, default: '{}'
  end
end

class RelateVotesToUser < ActiveRecord::Migration[6.0]
  def change
    remove_columns :votes, :user_id, :pizza_id
    add_reference :votes, :user, index: true
  end
end

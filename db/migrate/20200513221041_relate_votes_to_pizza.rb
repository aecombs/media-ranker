class RelateVotesToPizza < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :pizza, index: true
  end
end

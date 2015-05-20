class AddUserToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :user, index: true
    add_foreign_key :comments, :users
    user = User.first
    Comment.all.each {|u| u.update(user:  user)}
  end
end

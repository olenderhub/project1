class AddUserToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :user, index: true
    add_foreign_key :articles, :users
    user = User.first
    Article.all.each {|a| a.update(user: user)}
  end
end

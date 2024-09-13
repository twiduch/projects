

user_ariel = User.find_or_create_by(name: 'Ariel')
user_bob = User.find_or_create_by(name: 'Bob')
user_maria = User.find_or_create_by(name: 'Maria')
all_users = [user_ariel, user_bob, user_maria]

%w[
  Project1
  Project2
  Project3
].each do |name|
  project = Project.find_or_create_by(name: name)
  project.users << all_users
end

project = Project.find_or_create_by(name: 'Bob + Maria')
project.users << [user_bob, user_maria]
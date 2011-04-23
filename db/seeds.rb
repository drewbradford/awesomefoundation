# Create a sample chapter for development:
chapter = Chapter.create! :name => 'Atlantis', :slug => 'atlantis', :tagline => "It's hotter under de water", :body => "This is a development chapter."

# Create a sample user
user = User.new(:login => "Poseidon", :first_name => "Poseidon", :last_name => "Johnson", :password => "password", :password_confirmation => "password", :chapter_id => chapter.id, :admin => true)
user.admin = true
user.save
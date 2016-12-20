require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a playlist', :type => :feature) do
  it ('allows a user to create a playlist') do
    visit('/dashboard')
    click_link('Create Playlist')
    fill_in('playlist_name', :with => 'Ruby Lessons')
    fill_in('due_date', :with =>"2016-12-06")
    page.check('private')
    click_button('Submit Playlist')
    expect(page).to have_content('Hello')
  end

  it('allows a user to update and delete a playlist') do
    playlist = Playlist.create({:name => 'Happy Playlist', :due_date => '2016-12-12'})
    visit('/dashboard')
    click_link('Your Playlists')
    click_link('Happy Playlist')
    fill_in('playlist_name', :with => 'Sad Playlist')
    click_button('Update')
    expect(page).to have_content('Sad Playlist')
  end
end

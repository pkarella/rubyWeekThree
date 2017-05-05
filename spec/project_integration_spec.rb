require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to add and click a project') do
    visit('/')
    click_link('Add New Project')
    fill_in('name', :with =>'Peter')
    click_button('Add project')
    expect(page).to have_content('Peter')
  end
end

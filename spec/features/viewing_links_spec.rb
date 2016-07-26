require 'spec_helper.rb'
# require 'database_cleaner'

feature "Viewing links" do
  scenario "As a user I can see my links on the homepage" do
  Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end

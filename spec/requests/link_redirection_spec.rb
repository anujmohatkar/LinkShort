require "rails_helper"

RSpec.describe "Link redirection", type: :request do 
  
  it "redirects to the original URL for a given short link" do 
    url = "https://getbootstrap.com/docs/4.0/getting-started/download/"
    shortener = Shortener.new(url)
    link = shortener.generate_short_link

    get link.shortened_url

    expect(response).to redirect_to(link.original_url)
  end

end
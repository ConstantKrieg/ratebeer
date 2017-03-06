class RatingsJob
  include SuckerPunch::Job

  def perform
    Rails.cache.write("top beers", Beer.top(3))
    Rails.cache.write("top breweries", Brewery.top(3))
    Rails.cache.write("top styles", Beer.top(3))
    Rails.cache.write("latest", Rating.latest)
    Rails.cache.write("most active", User.most_active_users(5))
  end
end
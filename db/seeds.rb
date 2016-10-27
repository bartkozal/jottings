if Rails.env.development?
  User.create(email: "bkzl@me.com", password: 123)
  User.create(email: "mackozal@me.com", password: 123)
end

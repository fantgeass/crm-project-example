class Spbec.Collections.Users extends Backbone.QueryCollection
  url: Routes.users_path(format: 'json')
  model: Spbec.Models.User
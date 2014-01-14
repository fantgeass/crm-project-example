class Spbec.Collections.Tasks extends Backbone.QueryCollection
  url: Routes.tasks_path(format: 'json')
  model: Spbec.Models.Task
class Spbec.Collections.Departments extends Backbone.Collection
  model: Spbec.Models.Department
  url: Routes.departments_path(format: 'json')
class Spbec.Models.Company extends Backbone.Model
  url: Routes.companies_path(format: 'json')
  schema:
    title:
      type: 'Text'
      title: 'Название'
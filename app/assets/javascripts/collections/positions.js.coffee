class Spbec.Collections.Positions extends Backbone.Collection
  url: Routes.positions_path(format: 'json')
  model: Spbec.Models.Position
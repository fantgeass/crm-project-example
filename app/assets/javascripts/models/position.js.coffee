class Spbec.Models.Position extends Backbone.Model
  url: Routes.positions_path(format: 'json')

  toString: ->
    @get('title')
class Spbec.Models.Department extends Backbone.Model

  toString: ->
    @get('title')
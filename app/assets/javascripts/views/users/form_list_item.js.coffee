class Spbec.Views.UsersFormListItemView extends Backbone.View
  template: JST['users/form_list_item']
  tagName: 'li'
  className: 'media'
  events: {
  'click .action-close' : 'remove'
  }

  initialize: (options) ->
    @model_name = options.model_name

  remove: (e) ->
    e.preventDefault()
    @collection.remove(@model)

  render: ->
    $(@el).html(@template(user: @model, model_name: @model_name))
    return this

class Spbec.Views.AttachmentsFormListItem extends Backbone.View
  template: JST['attachments/form_list_item']
  tagName: 'li'
  events: {
    'click .action-close' : 'remove'
  }

  initialize: (options) ->
    @model_name = options.model_name

  remove: (e) ->
    e.preventDefault()
    @collection.remove(@model)

  render: ->
    $(@el).html(@template(attachment: @model, model_name: @model_name))
    return this

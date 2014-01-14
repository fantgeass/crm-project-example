class Spbec.Views.UsersTableItem extends Backbone.View
  template: JST['users/table_item']
  tagName: 'tr'

  initialize: (options) ->
    @disabled = options.disabled

  render: ->
    $(@el).html(@template(user: @model, disabled: @disabled))
    return this

  isChecked: ->
    checkbox = @$('input[name="user_id"]');
    return checkbox.prop('checked')

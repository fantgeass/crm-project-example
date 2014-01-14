class Spbec.Views.AttachmentsTableItem extends Backbone.View
  template: JST['attachments/table_item']
  tagName: 'tr'

  initialize: (options) ->
    @disabled = options.disabled

  render: ->
    $(@el).html(@template(attachment: @model, disabled: @disabled))
    return this

  isChecked: ->
    checkbox = @$('input[name="attachment_id"]');
    return checkbox.prop('checked')
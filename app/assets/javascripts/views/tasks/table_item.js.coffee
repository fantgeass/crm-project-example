class Spbec.Views.TasksTableItem extends Backbone.View
  template: JST['tasks/table_item']
  tagName: 'tr'

  initialize: (options) ->
    @disabled = options.disabled

  render: ->
    $(@el).html(@template(task: @model, disabled: @disabled))
    return this

  isChecked: ->
    checkbox = @$('input[name="task_id"]');
    return checkbox.prop('checked')
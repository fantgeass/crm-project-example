class Spbec.Views.TasksTable extends Backbone.View
  template: JST['tasks/table']

  initialize: (options) ->
    @chosen_tasks = options.chosen_tasks

  render: ->
    $(@el).html(@template())
    @renderTableItems()
    return this

  renderTableItems: ->
    @table_item_views = []
    for task in @collection.models
      if (@chosen_tasks.find((chosen) -> chosen.get('id') == task.get('id')))
        disabled = true
      else
        disabled = false

      view = new Spbec.Views.TasksTableItem(
        model: task
        disabled: disabled
      ).render()

      @table_item_views.push(view)
      @$('tbody').append(view.el)

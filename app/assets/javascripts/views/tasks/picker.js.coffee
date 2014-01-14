class Spbec.Views.TasksPicker extends Backbone.View
  template: JST['tasks/picker']

  events: {
    'keyup #task-title-picker' : 'renderTasksTable'
    'click #attach-tasks-button' : 'attachTasks'
  }

  initialize: (options) ->
    @chosen_tasks = options.chosen_tasks

  attachTasks: ->
    for item_view in @task_table_view.table_item_views
      if item_view.isChecked()
        @chosen_tasks.add(item_view.model)

    bootbox.hideAll()

  render: ->
    $(@el).html(@template())
    @renderTasksTable()
    return this

  renderTasksTable: ->
    title = @$('#task-title-picker').val();

    query = {title: {$likeI: title}} if title
    if query
      @filtered_tasks = new Spbec.Collections.Tasks(@collection.query(query))
    else
      @filtered_tasks = @collection

    @task_table_view = new Spbec.Views.TasksTable(
      collection: @filtered_tasks
      chosen_tasks: @chosen_tasks
      el: @$('#tasks-table')
    ).render();
class Spbec.Views.TasksFormList extends Backbone.View
  template: JST['tasks/form_list']

  events: {
    'click #add-task-link' : 'modalTasksPicker'
  }

  initialize: (options) ->
    @model_name = options.model_name
    @from_tasks = options.from_tasks
    @to_tasks = options.to_tasks
    @owner_tasks = options.owner_tasks

    for task in @from_tasks.models # this is flag for TasksFormListItem
      task.set(from_task_ids: true)

    @chosen_tasks = new Spbec.Collections.Tasks(@from_tasks.toJSON())
    @chosen_tasks.add(@to_tasks.toJSON())

    _.bindAll(@, 'render')
    @chosen_tasks.on('add', @render)
    @chosen_tasks.on('remove', @render)

  render: ->
    $(@el).html(@template())
    @renderFormListItems()
    return this

  renderFormListItems: ->
    @form_list_item_views = []
    for task in @chosen_tasks.models
      view = new Spbec.Views.TasksFormListItem(
        model: task
        collection: @chosen_tasks
        model_name: @model_name
      ).render()

      @form_list_item_views.push(view)
      @$('ol').append(view.el)

  modalTasksPicker: (e) ->
    e.preventDefault()

    view = new Spbec.Views.TasksPicker(
      collection: @owner_tasks
      chosen_tasks: @chosen_tasks
    ).render()

    bootbox.dialog(view.el, [],
       header:            "Задачи"
       headerCloseButton: '<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>'
    )
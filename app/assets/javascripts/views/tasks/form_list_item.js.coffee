class Spbec.Views.TasksFormListItem extends Backbone.View
  template: JST['tasks/form_list_item']
  tagName: 'li'
  events: {
    'click .action-close' : 'remove'
  }

  initialize: (options) ->
    @model_name = options.model_name

  render: ->
    $(@el).html(@template(
      task: @model
      model_name: @model_name
      relation_key: if @model.get('from_task_ids') then 'from_task_ids' else 'to_task_ids'
    ))
    return this

  remove: (e) ->
    e.preventDefault()
    @collection.remove(@model)
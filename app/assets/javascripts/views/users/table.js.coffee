class Spbec.Views.UsersTable extends Backbone.View
  template: JST['users/table']

  initialize: (options) ->
    @existed_users = options.existed_users # ids

  render: ->
    $(@el).html(@template())
    @renderTableItems()
    return this

  renderTableItems: ->
    @tableItemsViews = []

    for user in @collection.models
      if (_.find(@existed_users,(user_id) -> user_id == user.get('id')))
        disabled = true
      else
        disabled = false

      view = new Spbec.Views.UsersTableItem(
        model: user
        disabled: disabled
      ).render()

      @tableItemsViews.push(view)
      @$('tbody').append(view.el)
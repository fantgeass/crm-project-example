class Spbec.Views.UsersFormListView extends Backbone.View
  template: JST['users/form_list']

  events: {
    'click #add-user-link' : 'createModalWindow'
  }

  initialize: (options) ->
    @model_name = options.model_name
    @chosen_users = options.chosen_users
    @staff_users = options.staff_users

    _.bindAll(@, 'render')
    @chosen_users.on('add', @render)
    @chosen_users.on('remove', @render)

  createModalWindow: (e) ->
    @picker_view = new Spbec.Views.UsersPicker(
      chosen_users: @chosen_users
      users: @staff_users
    ).render()

    bootbox.dialog(@picker_view.el, [],
     header:            "Пользователи"
     headerCloseButton: '<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>'
    )


  render: ->
    $(@el).html(@template())
    @renderFormListItems()
    return this

  renderFormListItems: ->
    for user in @chosen_users.models
      view = new Spbec.Views.UsersFormListItemView(
        model: user
        model_name: @model_name
        collection: @chosen_users
      ).render()
      @$('ul').append(view.el)


class Spbec.Views.UsersPicker extends Backbone.View
  template: JST['users/picker']

  events:
    'keyup #fullname-picker':       'renderUsersTable'
    'click #attach-users-button':   'attachUsers'


  initialize: (options) ->
    @chosen_users = options.chosen_users
    @users = options.users

    _.bindAll(@, 'renderUsersTable')
    @chosen_users.on('add', @renderUsersTable)

  render: ->
    $(@el).html(@template(
      companies: @companies
    ))
    @renderUsersTable()
    return this

  attachUsers: (e) ->
    for itemView in @tableView.tableItemsViews
      if itemView.isChecked()
        @chosen_users.add(itemView.model)

    bootbox.hideAll()

  renderUsersTable: ->
    fullname      = @$('#fullname-picker').val();
    existed_users = for user in @chosen_users.models
      user.get('id')

    query = fullname: {$likeI: fullname}

    @filtered_users = @users.query(query)

    @tableView = new Spbec.Views.UsersTable(
      collection: new Spbec.Collections.Users(@filtered_users)
      existed_users: existed_users
      el: @$('#users-table')
    ).render()
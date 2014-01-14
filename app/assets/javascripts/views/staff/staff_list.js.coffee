class Spbec.Views.StaffList extends Backbone.View
  template: JST['staff/list']

  events: {
    'click #add-staff-link' : 'createModalWindow'
  }

  initialize: () ->
    _.bindAll(@, 'render')
    @collection.on('add', @saveMember)
    @collection.on('add', @render)
    @collection.on('remove', @render)
    @collection.on('change', @render)

  saveMember: (member) ->
    data = JSON.stringify(member.pick('staff_role_id', 'user_id'))
    member.save(null, {data: data, contentType: 'application/json'})

  createModalWindow: (e) ->
    view = new Spbec.Views.StaffWidget(
      existed_staff: @collection
    ).render()

    bootbox.dialog(view.el, [],
      classes: 'modal-user modal-spbec'
      header:            "Проектная группа"
      headerCloseButton: '<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>'
    )

  render: ->
    $(@el).html(@template())
    @renderStaffListItems()
    return this

  renderStaffListItems: ->
    for member, key in @collection.models
      view = new Spbec.Views.StaffListItem(
        key: key
        model: member
      ).render()

      is_role_title = key == 0 ||
        member.get('staff_role_title') != @collection.models[key-1].get('staff_role_title')

      $(view.el).prepend("<div class='person-role'>#{member.get('staff_role_title')}</div>") if is_role_title

      @$('ul.persons-list').append(view.el)

class Spbec.Views.StaffFormList extends Backbone.View
  template: JST['staff/form_list']

  events: {
    'click #add-staff-link' : 'createModalWindow'
  }

  initialize: () ->
    _.bindAll(@, 'render')
    @collection.on('add', @render)
    @collection.on('remove', @render)
    @collection.on('change', @render)

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
    @collection.query({}, {order: 'staff_role_id'})
    $(@el).html(@template())
    @renderStaffFormListItems()
    return this

  renderStaffFormListItems: ->
    for member, key in @collection.models
      view = new Spbec.Views.StaffFormListItem(
        key: key
        model: member
        collection: @collection
      ).render()

      is_role_title = key == 0 ||
        member.get('staff_role_title') != @collection.models[key-1].get('staff_role_title')
      if is_role_title
        @$('ul').append($('<b>', text: member.get('staff_role_title')))

      @$('ul').append(view.el)

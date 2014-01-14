class Spbec.Views.StaffWidget extends Backbone.View
  template: JST['staff/widget']

  events: {
    'click a[href="#new-user-tab"]' : 'renderUserForm'
    'click a[href="#staff-picker-tab"], a[href="#new-user-tab"]' : 'toggleFooterButton'
  }

  initialize: (options) ->
    @existed_staff = options.existed_staff

  render: ->
    @fetchUsers().done =>
      $(@el).html(@template())
      @renderStaffPicker()
      @renderButtons()

    return this

  renderButtons: ->
    @staff_pick_button = $('<button>',{
      id: 'attach-staff-button'
      class: 'btn btn-spbec pull-right'
      text: 'Прикрепить'
    })

    @user_create_button = $('<button>',{
      id: 'submit-user-button'
      class: 'btn btn-spbec pull-right hide'
      text: 'Создать'
    })

    modal_footer = $('<div>', {
    class: 'modal-footer'
    })
    modal_footer.append(@staff_pick_button)
    modal_footer.append(@user_create_button)
    $('.modal-body').after(modal_footer)
    @staff_pick_button.on('click', @staffPickerView.attachStaff)


  toggleFooterButton: (e) ->
    href = e.target.getAttribute('href')
    if href is '#staff-picker-tab'
      @staff_pick_button.show()
      @user_create_button.hide()
    else
      @staff_pick_button.hide()
      @user_create_button.show()

  renderStaffPicker: ->
    @staffPickerView = new Spbec.Views.StaffPicker(
      existed_staff: @existed_staff
      users: @users
      el: @$('#staff-picker-tab')
    ).render()


  renderUserForm: (e) ->
    @$('#new-user-tab').html('loading...')
    @userFormView = new Spbec.Views.StaffUserForm(
      staff_roles : @staffPickerView.staff_roles
      existed_staff : @existed_staff
      users : @users
      el: @$('#new-user-tab')
    ).render()
    $(@el).undelegate('a[href="#new-user-tab"]', 'click')
    @user_create_button.on('click', @userFormView.save)

  fetchUsers: ->
    @users = new Spbec.Collections.Users()
    @users.fetch()
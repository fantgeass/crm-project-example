class Spbec.Views.StaffUserForm extends Backbone.View

  events: {
    'ajax:success form' : 'successSave'
  }

  initialize: (options) ->
    @staff_roles = options.staff_roles
    @existed_staff = options.existed_staff
    @users = options.users

  render: ->
    $.trafficCop(Routes.users_form_path()).done((data) =>
      $(@el).html(data)
      $(@el).find('form').enableClientSideValidations()
      @renderStaffRoles()
      $('#user_date_of_birth').datepicker()
    )
    return this

  # we moved button to another dom, so we manually attach event in render method
  save: (e) =>
    form = @$('form');
    form.submit()

  successSave: (xhr, data) ->
    notify('Новый пользователь успешно добавлен!')

    @existed_staff.add(
      staff_role_id:    @$('#staff_role_id').val()
      staff_role_title: @$('#staff_role_id option:checked').text()
      user_id:          data.id
      user_fullname:    data.fullname
      user_avatar_tag:  data.avatar_tag
    )
    @users.add(data)

    @render()

  renderStaffRoles: ->
    @$('.form-field:last').after(JST['staff/choose_role'](staff_roles: @staff_roles))

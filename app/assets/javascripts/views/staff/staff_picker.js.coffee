class Spbec.Views.StaffPicker extends Backbone.View
  template: JST['staff/picker']

  events: {
  'change #company-id-picker':    'renderUsersTable'
  'keyup #fullname-picker':       'renderUsersTable'
  'change #department-id-picker': 'renderUsersTable'
  'change #position-id-picker':   'renderUsersTable'
  }

  initialize: (options) ->
    @existed_staff = options.existed_staff
    @users = options.users

    _.bindAll(@, 'renderUsersTable')
    @users.on('add', @renderUsersTable)

  render: ->
    $.when(
      @fetchCompanies()
    ).then =>
      $(@el).html(@template(
        companies: @companies
      ))

      @fetchStaffRoles()
      @fetchDepartments()
      @fetchPositions()
      @renderUsersTable()

    return this


  fetchStaffRoles: ->
    @staff_roles =  new Spbec.Collections.StaffRoles()
    @staff_roles.fetch().done =>
      for staff_role in @staff_roles.models
        @$('#staff-role-id-picker').append($('<option>', {
          value: staff_role.get('id')
          text: staff_role.get('title')
        }))

  fetchCompanies: ->
    @companies = new Spbec.Collections.Companies()
    @companies.fetch()

  fetchDepartments: ->
    @departments = new Spbec.Collections.Departments()
    @departments.fetch().done =>
      for department in @departments.models
        @$('#department-id-picker').append($('<option>', {
          value: department.get('id')
          text: department.get('title')
        }))

  fetchPositions: ->
    @positions = new Spbec.Collections.Positions()
    @positions.fetch().done =>
      for position in @positions.models
        @$('#position-id-picker').append($('<option>', {
          value: position.get('id')
          text: position.get('title')
        }))

  # we moved button to another dom, so we manually attach event in render method
  attachStaff: (e) =>
    for itemView in @tableView.tableItemsViews
      if itemView.isChecked()
        user = itemView.model
        @existed_staff.add(
          staff_role_id:    @$('#staff-role-id-picker').val()
          staff_role_title: @$('#staff-role-id-picker option:checked').text()
          user_id:          user.get('id')
          user_fullname:    user.get('fullname')
          user_email:       user.get('email')
          user_phone:       user.get('phone')
          user_avatar_tag:  user.get('avatar_tag')
          user_avatar_url:  user.get('avatar_url')
        )

    bootbox.hideAll()

  renderUsersTable: ->
    company_id = parseInt(@$('#company-id-picker').val());
    fullname = @$('#fullname-picker').val();
    department_id = parseInt(@$('#department-id-picker').val());
    position_id = parseInt(@$('#position-id-picker').val());

    existed_users = for member in @existed_staff.models
      unless member._destroy
        member.get('user_id')

#    query = company_id: company_id
    query = {}
    query.fullname = {$likeI: fullname} if fullname
    query.department_id = {$equal: department_id} if department_id
    query.position_id = {$equal: position_id} if position_id

    @filtered_users = @users.query(query)

    @tableView = new Spbec.Views.UsersTable(
      collection: new Spbec.Collections.Users(@filtered_users)
      existed_users: existed_users
      el: @$('#staff-users-table')
    ).render()
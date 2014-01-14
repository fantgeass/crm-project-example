class Spbec.Views.TcpForm extends Backbone.View
  events: {
    'change #tcp_company_id' : 'setClients'
    'click #add-company-link' : 'companyModal'
    'click #add-client-link' : 'clientModal'
  },

  initialize: (options) ->
    @users = options.users
    @company_selector  = @$('#tcp_company_id')
    @client_selector  = @$('#tcp_client_id')
    @client_block_selector  = @$('#client-block')
    @start_date_selector = @$('#tcp_planned_start_date')
    @complete_date_selector = @$('#tcp_planned_complete_date')

    @company_selector.select2()
    @client_selector.select2()
    @setupDatePickers()

    if @company_selector.val() isnt ''
      @client_block_selector.show()

  setupDatePickers: ->
    @start_date_selector.datepicker(
      numberOfMonths: 3
      onClose: =>
        date = new Date()
        date.setDate(@start_date_selector.datepicker('getDate').getDate()+1)
        @complete_date_selector.datepicker("option", "minDate", date)
    )
    @complete_date_selector.datepicker(
      numberOfMonths: 3
      onClose: =>
        date = new Date()
        date.setDate(@complete_date_selector.datepicker('getDate').getDate()-1)
        @start_date_selector.datepicker("option", "maxDate", date)
    )

  companyModal: (e) ->
    e.preventDefault()

    @company_form_view = new Spbec.Views.CompanyForm(
      model: new Spbec.Models.Company()
    ).render()

    bootbox.dialog(@company_form_view.el, [],
     header: "Добавить компанию"
     headerCloseButton: "<button aria-hidden=\"true\" data-dismiss=\"modal\" class=\"close\" type=\"button\"></button>"
    )

  clientModal: (e) ->
    e.preventDefault()

    user = new Spbec.Models.User()
    user.set(
      company_id: @$('#tcp_company_id').val()
      company_title: @$('#tcp_company_id option:checked').text()
    )

    @new_user_form_view = new Spbec.Views.NewUserForm(
      model: user
    ).render()

    bootbox.dialog(@new_user_form_view.el, [],
      header: "Добавить пользователя"
      headerCloseButton: "<button aria-hidden=\"true\" data-dismiss=\"modal\" class=\"close\" type=\"button\"></button>"
    )

  setClients: (e) ->
#    @client_block_selector.addClass('hide')
    company_id = parseInt(@company_selector.val())
    company_users = @users.where(company_id: company_id)

    @client_selector.html($('<option>')) # clear field
    for user in company_users
      @client_selector.append($('<option>', {
        value: user.get('id')
        text: user.get('fullname')
      }))

    @client_selector.select2('val', '')
    @client_selector.change()
#    @client_block_selector.removeClass('hide').fadeIn()



class Spbec.Views.AttachmentsFilterForm extends Backbone.View

  events:
    'click input[type="reset"]' : 'reset'

  initialize: (options) ->
    @start_date_selector = @$('#start_date')
    @finish_date_selector = @$('#finish_date')
    @setupDatePickers()

  setupDatePickers: ->
    @start_date_selector.datepicker(
      numberOfMonths: 3
      onClose: =>
        date = new Date()
        date.setDate(@start_date_selector.datepicker('getDate').getDate()+1)
        @finish_date_selector.datepicker("option", "minDate", date)
    )
    @finish_date_selector.datepicker(
      numberOfMonths: 3
      onClose: =>
        date = new Date()
        date.setDate(@finish_date_selector.datepicker('getDate').getDate()-1)
        @start_date_selector.datepicker("option", "maxDate", date)
    )

  reset: (e) ->
    e.preventDefault()
    @$('input[type="text"], select, textarea').val('')
    @$('input[type="submit"]').click()
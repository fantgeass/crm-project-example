class Spbec.Views.TaskableForm extends Backbone.View

  initialize: (options) ->
    @priority_field = @$("##{options.model_name}_priority")
    @start_date_selector = @$("##{options.model_name}_planned_start_date")
    @complete_date_selector = @$("##{options.model_name}_planned_complete_date")
    @setupDatePickers()
    @setupPriority()

  setupPriority: ->
    @$('#pick-high-priority').click =>
      @priority_field.val('high')
    @$('#pick-medium-priority').click =>
      @priority_field.val('medium')
    @$('#pick-low-priority').click =>
      @priority_field.val('low')


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



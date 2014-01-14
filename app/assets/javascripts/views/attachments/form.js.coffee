class Spbec.Views.AttachmentForm extends Backbone.View

  events:
    'click #choose-tcp' : 'chooseTcp'
    'click #choose-project' : 'chooseProject'
    'change #attachment_tcps, #attachment_projects' : 'changeFormAction'

  chooseProject: (e) ->
    @_chooser(@attachments_projects_selector, @attachments_tcps_selector, 'projects')

  chooseTcp: (e) ->
    @_chooser(@attachments_tcps_selector, @attachments_projects_selector, 'tcps')

  _chooser: (to, from, begin_path_with) ->
    to.show()
    to.removeAttr('disabled')
    from.hide()
    from.attr('disabled', 1)
    to.change() # for event invoke

  changeFormAction: (e) ->
    t = $(e.target)
    id = t.val()

    if id is ''
      @form_selector.attr('action', "/attachments")
    else
      if t.attr('id') is 'attachment_tcps'
        begin_path_with = 'tcps'
      else
        begin_path_with = 'projects'

      @form_selector.attr('action', "/#{begin_path_with}/#{id}/attachments")

  initialize: (options) ->
    @form_url = if options.form_url then options.form_url else Routes.attachments_form_path()

  render: ->
    $.trafficCop(@form_url).done((data) =>
      $(@el).html(data)
      $(@el).find('form').enableClientSideValidations()
      @fileUpload()
      @attachments_tcps_selector = @$('#attachment_tcps')
      @attachments_projects_selector = @$('#attachment_projects')
      @form_selector = @$('form')
    )
    return this

  # button is outside of this view
  save: (e) =>
    e.preventDefault()
    is_valid = $('#new_attachment').isValid(ClientSideValidations.forms.new_attachment.validators);
    if is_valid and @file
      @attachments_tcps_selector.attr('disabled', 1)
      @attachments_projects_selector.attr('disabled', 1)
      @file.submit().done( (data) =>
        if @collection is undefined
         location.reload()
        else
          @collection.add(data)
      )

  fileUpload: ->
    @$('#attachment_file').fileupload(
      replaceFileInput: false
      dataType: 'json'
      add: (evt, data) =>
        @file = data

      done: (evt, data) =>
        notify('Новый файл успешно добавлен!')
        @render()
    )

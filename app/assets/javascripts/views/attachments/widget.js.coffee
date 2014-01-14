class Spbec.Views.AttachmentsWidget extends Backbone.View
  template: JST['attachments/widget'],

  events: {
    'click a[href="#new-attachment-tab"]' : 'renderAttachmentForm'
    'click a[href="#attachments-picker-tab"], a[href="#new-attachment-tab"]' : 'toggleFooterButton'
  }

  initialize: (options) ->
    @chosen_attachments = options.chosen_attachments
    @form_url = options.form_url

  render: ->
    $(@el).html(@template())
    @renderAttachmentsPicker()
    return this

  renderButtons: ->
    @attachments_pick_button = $('<button>',{
      id: 'attach-attachments-button'
      class: 'btn btn-spbec pull-right'
      text: 'Прикрепить'
    })

    @attachment_create_button = $('<button>',{
      id: 'submit_attachment'
      class: 'btn btn-spbec pull-right hide'
      text: 'Создать'
    })
    modal_footer = $('<div>', {
      class: 'modal-footer'
    })
    modal_footer.append(@attachments_pick_button)
    modal_footer.append(@attachment_create_button)
    $('.modal-body').after(modal_footer)
    @attachments_pick_button.on('click', @attachmentPickerView.attachAttachments)


  toggleFooterButton: (e) ->
    href = e.target.getAttribute('href')
    if href is '#attachments-picker-tab'
      @attachments_pick_button.show()
      @attachment_create_button.hide()
    else
      @attachments_pick_button.hide()
      @attachment_create_button.show()

  renderAttachmentForm: (e) ->
    @$('#new-attachment-tab').html('loading...')
    @attachmentFormView = new Spbec.Views.AttachmentForm(
      collection: @attachmentPickerView.collection
      form_url: @form_url
      el: @$('#new-attachment-tab')
    ).render()
    $(@el).undelegate('a[href="#new-attachment-tab"]', 'click')
    @attachment_create_button.on('click', @attachmentFormView.save)


  renderAttachmentsPicker: ->
    @attachmentPickerView = new Spbec.Views.AttachmentsPicker(
      chosen_attachments: @chosen_attachments
      el: @$('#attachments-picker-tab')
    ).render()

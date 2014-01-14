class Spbec.Views.AttachmentsNewButton extends Backbone.View

  events:
    'click #add-attachment-button' : 'createModal'

  initialize: (options) ->
    @form_url = options.form_url

  createModal: (e) ->
    e.preventDefault()

    bootbox.dialog('', [],
      header:            "Добавить файл"
      headerCloseButton: '<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>'
    )

    @attachmentFormView = new Spbec.Views.AttachmentForm(
      form_url: @form_url
      el: $('.modal-body')
    ).render()
    @renderButton()

  renderButton: ->
    @attachment_create_button = $('<button>',{
      id: 'submit_attachment'
      class: 'btn btn-spbec pull-right'
      text: 'Создать'
    })
    modal_footer = $('<div>', {
      class: 'modal-footer'
    })
    modal_footer.append(@attachment_create_button)
    $('.modal-body').after(modal_footer)
    @attachment_create_button.on('click', @attachmentFormView.save)

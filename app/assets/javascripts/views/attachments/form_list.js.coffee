class Spbec.Views.AttachmentsFormList extends Backbone.View
  template: JST['attachments/form_list']

  events: {
    'click #add-attachments-link': 'modalAttachmentsWidget'
  }

  initialize: (options) ->
    @template = options.template if options.template
    @model_name = options.model_name
    @chosen_attachments = options.chosen_attachments
    @form_url = options.form_url

    _.bindAll(@, 'render')
    @chosen_attachments.on('add', @render)
    @chosen_attachments.on('remove', @render)

  modalAttachmentsWidget: (e) ->
    e.preventDefault()

    @widget_view = new Spbec.Views.AttachmentsWidget(
      form_url: @form_url
      chosen_attachments: @chosen_attachments
    ).render()

    bootbox.dialog(@widget_view.el, [],
       header:            "Файлы"
       headerCloseButton: '<button aria-hidden="true" data-dismiss="modal" class="close" type="button"></button>'
    )
    @widget_view.renderButtons()



  render: ->
    $(@el).html(@template())
    @renderFormListItems()
    return this

  renderFormListItems: ->
    for attachment in @chosen_attachments.models
      view = new Spbec.Views.AttachmentsFormListItem(
        model: attachment
        collection: @chosen_attachments
        model_name: @model_name
      ).render()
      @$('ul').append(view.el)

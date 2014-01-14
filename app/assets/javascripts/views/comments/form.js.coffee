class Spbec.Views.CommentsForm extends Backbone.View
  template: JST['comments/form']
  tagName: 'form'
  events:
    'click input[type="submit"]' : 'save'

  initialize: (options) ->
    @attachments_form_url = options.attachments_form_url

  validate: ->
    if @model.get('body') is ''
      @$('.alert-error').show()
      return false
    else
      @$('.alert-error').hide()
      return true
    
  save: (e) ->
    e.preventDefault()

    if @validate()
      attachment_ids_selectors = @$('input[name="comment[attachment_ids][]"]')
      ids = []
      attachment_ids_selectors.each ->
        ids.push $(@).val()

      @model.set({attachment_ids: ids})
      @model.save().done =>
        notify('Новый комментарий успешно добавлен!')
        @collection.add(@model)

  render: ->
    $(@el).html(@template())
    rivets.bind($(@el), {comment: @model})
    @renderAttachmentsFormList()
    return this

  renderAttachmentsFormList: ->
    @attachmentsFormListView = new Spbec.Views.AttachmentsFormList(
      chosen_attachments: new Spbec.Collections.Attachments()
      form_url: @attachments_form_url
      template: JST['attachments/comment_form_list']
      model_name: 'comment'
      el: @$('#attachments-form-list')
    ).render();

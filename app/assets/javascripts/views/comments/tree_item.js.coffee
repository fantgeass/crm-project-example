class Spbec.Views.CommentsItem extends Backbone.View
  template: JST['comments/item']
  tagName: 'li'
  className: 'media'

  events:
    'click a.answer-comment:first': 'moveForm'
    'click a.cancel':               'cancelMoveForm'
#    'click a.update-comment:first' : 'update'
    'click a.delete-comment:first': 'delete'


  initialize: (options) ->
    @commentsFormView = options.commentsFormView

    _.bindAll(@, 'render')
    @model.on('change', @render)

    @el.id = "comment-#{@model.id}"

  cancelMoveForm: (e) ->
    @answer_link.show()
    @commentsFormView.model.set(parent_id: '')
    $('.comment-add-new').append(@commentsFormView.el)

  moveForm: (e) ->
    e.preventDefault()
    @answer_link = $(e.target)
    @answer_link.hide()

    @commentsFormView.model.set(parent_id: @model.id)
    $(e.target).parent().after(@commentsFormView.el)

  update: (e) ->
    e.preventDefault()
    console.log(@model.toJSON())
#    $(e.target).addClass('hide')
#    @$('.save-comment').removeClass('hide')
#    @form.find('textarea').text(@model.body)
#    @$('.content:first').html(@form.el)


  delete: (e) ->
    e.preventDefault()
    if confirm('Вы уверены, что хотите удалить комментарий?')
      @model.destroy()
      notify('Комментарий успешно удален!', 'alert')

  render: ->
    $(@el).html(@template(comment: @model))
    rivets.bind($(@el), {comment: @model})
    return this


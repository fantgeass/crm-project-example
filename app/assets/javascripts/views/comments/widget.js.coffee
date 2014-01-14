class Spbec.Views.CommentsWidget extends Backbone.View
  template: JST['comments/widget']
  className: 'comments'

  events: {
    'click .answer-new-comment' : 'moveForm'
  }

  initialize: (options) ->
    @comments_url = options.comments_url
    @attachments_form_url = options.attachments_form_url

    _.bindAll(@, 'render')
    @collection.on('add', @render)
    @collection.on('remove', @render)

  moveForm: (e) ->
    e.preventDefault()
    @commentsFormView.model.set(parent_id: '')
    $(e.target).after(@commentsFormView.el)

  render: ->
    $(@el).html(@template())
    @renderForm()
    @renderCommentsTree()

    return this

  renderForm: ->
    @commentsFormView = new Spbec.Views.CommentsForm(
      model: new Spbec.Models.Comment({}, urlRoot: @comments_url)
      attachments_form_url: @attachments_form_url
      collection: @collection
    ).render()
    @$('.comment-add-new').append(@commentsFormView.el)

  renderCommentsTree: ->
    @commentsTreeView = new Spbec.Views.CommentsTree(
      collection: @collection
      commentsFormView: @commentsFormView
      el: @$('ul.list-comments')
    ).render()


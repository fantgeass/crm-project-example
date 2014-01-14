class Spbec.Views.CommentsTree extends Backbone.View
  template: JST['comments/tree']

  initialize: (options) ->
    @commentsFormView = options.commentsFormView

  render: ->
    @collection.each (comment) =>
      @commentToHisPlace(comment)

    return this

  commentToHisPlace: (model) ->
    view = new Spbec.Views.CommentsItem(
      model: model
      commentsFormView: @commentsFormView
    )
    comment_html = view.render().el
    if model.get('parent_id') is null
      $(@el).append(comment_html)
    else
      @$("#comment-#{model.get('parent_id')}").find('.list-sub-comments').append(comment_html)

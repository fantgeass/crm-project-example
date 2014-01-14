class Spbec.Models.User extends Backbone.Model
  url: Routes.users_path(format: 'json')


  getNewUserFormSchema: ->
    {
      fullname: {title: 'Полное имя'}
      email: {title: 'Почтовый ящик'}
      password: {title: 'Пароль'}
      department_id: {type: 'Select', options: new Spbec.Collections.Departments(), title: 'Департамент'},
      position_id: {type: 'Select', options: new Spbec.Collections.Positions(), title: 'Должность'},
    }

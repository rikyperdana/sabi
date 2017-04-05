# Routing Codes
Router.configure
    layoutTemplate: 'layout'
    loadingTemplate: 'loading'

Router.route '/',
    action: -> this.render 'home'

Router.route '/list',
    action: -> this.render 'list'
    waitOn: -> Meteor.subscribe 'datas'

Router.route '/create',
    action: -> this.render 'create'

Router.route '/read/:id',
    action: -> this.render 'read'
    waitOn: -> [
        Meteor.subscribe 'data', this.params.id
        Meteor.subscribe 'childs', this.params.id
    ]

Router.route '/update/:id',
    action: -> this.render 'update'
    waitOn: -> Meteor.subscribe 'data', this.params.id

# Database Codes
@crud = new Meteor.Collection 'crud'
@crudS = new SimpleSchema
    name:
        type: String
        label: 'Your Name'
    age:
        type: String
        label: 'Your Age'
    address:
        type: String
        label: 'Your Home Address'

crud.attachSchema crudS

crud.allow
    insert: -> true
    update: -> true
    remove: -> true

# Methods Codes
Meteor.methods
    'removeData': (id) ->
        crud.remove id

# Accounts Entry Config
Meteor.startup ->
    AccountsEntry.config
        waitEmailVerification: false
        dashboardRoute: '/list'
        homeRoute: '/'

# Child Database Codes
@child = new Mongo.Collection 'child'
@childS = new SimpleSchema
    parent:
        type: String
        autoValue: ->
            if Meteor.isClient
                Router.current().params.id
        autoform:
            type: 'hidden'
    contact:
        type: String
        label: 'Contact Number'
    email:
        type: String
        label: 'E-Mail Address'

child.attachSchema childS

child.allow
    insert: -> true
    update: -> true
    remove: -> true

Meteor.methods
    'removeDetail': (id) ->
        child.remove id

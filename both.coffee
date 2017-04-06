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
        label: 'Patient Name'
    age:
        type: Number
        label: 'Patient Age'
    address:
        type: String
        label: 'Patient Address'

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
    title:
        type: String
        label: 'Case Name'
    amount:
        type: Number
        label: 'Medication Fee'

child.attachSchema childS

child.allow
    insert: -> true
    update: -> true
    remove: -> true

Meteor.methods
    'removeDetail': (id) ->
        child.remove id

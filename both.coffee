# Routing Codes -----------------------------------------------------------------------------------
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

Router.route '/map',
    action: -> this.render 'globalMap', to:'fullWidth'
    waitOn: -> Meteor.subscribe 'datas'



# Database Codes ----------------------------------------------------------------------------------
@crud = new Meteor.Collection 'crud'
@crudS = new SimpleSchema
    name:
        type: String
        label: 'Person Name'
        autoform: id: 'nameField'
    age:
        type: Number
        label: 'Person Age'
        autoform: id: 'ageField'
    address:
        type: String
        label: 'Person Address'
        autoform:
            id: 'addressField'
    fileId:
        type: String
        autoform:
            afFieldInput:
                type: 'cfs-file'
                collection: 'files'
        optional: true

crud.attachSchema crudS
crud.allow
    insert: -> true
    update: -> true
    remove: -> true


@files = new FS.Collection 'files',
    stores: [new FS.Store.GridFS 'filesStore']
files.allow
    insert: -> true
    update: -> true
    download: -> true
    fetch: null


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
        label: 'Detail Name'
    amount:
        type: Number
        label: 'Detail Amount'

child.attachSchema childS
child.allow
    insert: -> true
    update: -> true
    remove: -> true



# Methods Codes -----------------------------------------------------------------------------------
Meteor.methods
    'removeData': (id) ->
        crud.remove id
    'removeFile': (fileId) ->
        files.remove fileId
    'removeDetail': (id) ->
        child.remove id



# Accounts Entry Config ---------------------------------------------------------------------------
Meteor.startup ->
    AccountsEntry.config
        waitEmailVerification: false
        dashboardRoute: '/list'
        homeRoute: '/'

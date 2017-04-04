if Meteor.isServer

    Meteor.publish 'datas', ->
        crud.find {}

    Meteor.publish 'data', (id) ->
        crud.find _id: id

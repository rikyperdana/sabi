if Meteor.isServer

    Meteor.publish 'datas', ->
        crud.find {}

    Meteor.publish 'data', (id) ->
        crud.find _id: id

    Meteor.publish 'childs', (parentId) ->
        child.find parent: parentId

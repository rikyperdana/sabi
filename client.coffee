if Meteor.isClient

    Template.list.helpers
        datas: ->
            crud.find {}

    Template.list.events
        'click #remove': ->
            $('#removeModal').openModal()

        'click #doRemove': ->
            Meteor.call 'removeData', this._id

        'click #dropAction': ->
            $('#dropAction').dropdown('open')

    Template.read.helpers
        data: ->
            crud.findOne()

    Template.update.helpers
        data: ->
            crud.findOne()

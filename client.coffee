if Meteor.isClient

    Template.list.helpers
        datas: ->
            crud.find {}

    Template.list.events
        'click #remove': ->
            $('#removeModal').openModal()

        'click #doRemove': ->
            Meteor.call 'removeData', this._id

        'click .dropdown-button': ->
            $('.dropdown-button').dropdown
                hover: true

    Template.read.helpers
        data: ->
            crud.findOne()

    Template.update.helpers
        data: ->
            crud.findOne()

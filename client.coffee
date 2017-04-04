if Meteor.isClient

    Template.menu.helpers
        loggedIn: ->
            true if Meteor.userId()
        userEmail: ->
            Meteor.user().emails[0].address

    Template.list.helpers
        datas: ->
            crud.find {}

    Template.list.events
        'click #remove': ->
            $('#removeModal').openModal()

        'click #doRemove': ->
            Meteor.call 'removeData', this._id

        'click .dropdown-button': ->
            $('.dropdown-button').dropdown 'open'

    Template.read.helpers
        data: ->
            crud.findOne()

    Template.update.helpers
        data: ->
            crud.findOne()

if Meteor.isClient

    Template.menu.helpers
        loggedIn: ->
            true if Meteor.userId()

        userEmail: ->
            Meteor.user().emails[0].address

    Template.menu.events
        'click .button-collapse': ->
            $('.button-collapse').sideNav()

    Template.list.helpers
        datas: ->
            crud.find {}, sort: name: 1

        empty: ->
            true if crud.find().fetch().length is 0

        actionable: ->
            true if Meteor.userId()

    Template.list.events
        'click .openDeleteModal': ->
            selector = '#deleteModal-'
            selector += this._id
            $(selector).openModal()

        'click .doRemove': ->
            Meteor.call 'removeData', this._id
            Materialize.toast 'Data has been deleted.', 4000, 'red'

        'click .dropdown-button': ->
            $('.dropdown-button').dropdown 'open'

    Template.create.events
        'submit form': ->
            Router.go '/list'
            Materialize.toast 'Successfully inserted!', 4000, 'blue'

    Template.read.helpers
        data: ->
            crud.findOne()

    Template.update.helpers
        data: ->
            crud.findOne()

    Template.update.events
        'submit form': ->
            Router.go '/list'
            Materialize.toast 'Data has been updated!', 4000, 'purple'

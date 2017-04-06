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

    Template.read.onRendered ->
        Session.set 'addDetail', false

    Template.read.helpers
        data: ->
            crud.findOne()
        childs: ->
            child.find {}
        addDetail: ->
            true if Session.get 'addDetail'
        empty: ->
            true if child.find().fetch().length is 0
        myChart: ->
            name = crud.findOne().name
            columnData = [name]
            childs = child.find().fetch()
            for i in childs
                columnData.push i.amount
            data:
                columns: [columnData],
                type: 'spline'

    Template.read.events
        'click .addDetail': ->
            Session.set 'addDetail', not Session.get 'addDetail'
        'click .removeDetail': ->
            Meteor.call 'removeDetail', this._id

    Template.update.helpers
        data: ->
            crud.findOne()

    Template.update.events
        'submit form': ->
            Router.go '/list'
            Materialize.toast 'Data has been updated!', 4000, 'purple'

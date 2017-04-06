if Meteor.isClient

    Template.menu.helpers
        loggedIn: ->
            true if Meteor.userId()

        userEmail: ->
            Meteor.user().emails[0].address

    Template.menu.events
        'click .button-collapse': ->
            $('.button-collapse').sideNav()

    Template.list.onRendered ->
        Session.set 'listSearch', ''

    Template.list.helpers
        datas: ->
            term = Session.get 'listSearch'
            if term isnt ''
                _.filter crud.find().fetch(), (doc) ->
                    doc.name.toLowerCase().includes(term) or
                    doc.address.toLowerCase().includes term
            else
                crud.find {}
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

        'keyup #search': (event) ->
            Session.set 'listSearch', event.target.value.toLowerCase()
         
         'dblclick .rowData': ->
            Router.go '/read/' + this._id
            
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
            columnData = [crud.findOne().name]
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

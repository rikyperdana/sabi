if Meteor.isClient

    Template.menu.helpers
        loggedIn: ->
            true if Meteor.userId()

        userEmail: ->
            Meteor.user().emails[0].address

    Template.menu.events
        'click .button-collapse': ->
            $('.button-collapse').sideNav()

    Template.home.onRendered ->
        $('.slider').slider()

    Template.list.helpers
        datas: ->
            term = Session.get 'listSearch'
            if term isnt undefined
                _.filter crud.find().fetch(), (doc) ->
                    doc.name.toLowerCase().includes(term) or
                    doc.address.toLowerCase().includes term
            else
                crud.find {}, sort: name: 1
        empty: ->
            true if crud.find().fetch().length is 0

        actionable: ->
            true if Meteor.userId()

    Template.list.events
        'click .openDeleteModal': ->
            selector = '#deleteModal-' + this._id
            $(selector).openModal()

        'click .doRemove': ->
            Meteor.call 'removeData', this._id
            Materialize.toast 'Data has been deleted.', 4000, 'red'

        'click .dropdown-button': ->
            $('.dropdown-button').dropdown 'open'

        'keyup #search': (event) ->
            Session.set 'listSearch', event.target.value.toLowerCase()

        'dblclick .rowData': ->
            if Meteor.userId()
                Router.go '/read/' + this._id

    Template.read.onRendered ->
        Session.set 'addDetail', false
        $('.tooltipped').tooltip delay: 50

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
        'click .print': ->
            childsTable = [['Title', 'Amount']]
            for i in child.find().fetch()
                row = [i.title, i.amount.toString()]
                childsTable.push row
            person = crud.findOne()
            pdfContent = pdfMake.createPdf
                header: 'Data Report'
                footer: 'from Meteor CRUD'
                content: [
                    'Person Name : ' + person.name
                    'Person Age : ' + person.age
                    'Person Address : ' + person.address
                    table:
                        headerRows: 1
                        body: childsTable
                ]
            pdfContent.open()

    Template.update.helpers
        data: ->
            crud.findOne()

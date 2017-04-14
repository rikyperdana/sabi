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

    Template.list.onRendered ->
        $('.dropdown-button').dropdown()
        

    Template.list.events
        'click .openDeleteModal': ->
            selector = '#deleteModal-' + this._id
            $(selector).openModal()

        'click .doRemove': ->
            Meteor.call 'removeData', this._id
            Materialize.toast 'Data has been deleted.', 4000, 'red'

        'keyup #search': (event) ->
            Session.set 'listSearch', event.target.value.toLowerCase()

        'dblclick .rowData': ->
            if Meteor.userId()
                Router.go '/read/' + this._id

    Template.read.onRendered ->
        Meteor.subscribe 'file', crud.findOne().file
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
        totalAmount: ->
            total = 0
            for i in child.find().fetch()
                total += i.amount
            numeral(total).format '0,0'
        file: ->
            files.findOne().with()

    Template.read.events
        'click .addDetail': ->
            Session.set 'addDetail', not Session.get 'addDetail'
        'click .removeDetail': ->
            Meteor.call 'removeDetail', this._id
        'click .print': ->
            childsTable = [['Title', 'Amount']]
            for i in child.find().fetch()
                childsTable.push [i.title, i.amount.toString()]
            person = crud.findOne()
            totalAmount = 0
            for i in child.find().fetch()
                totalAmount += i.amount
            childsTable.push ['Total', totalAmount.toString()]
            pdf = pdfMake.createPdf
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
            pdf.open()

    Template.update.helpers
        data: ->
            crud.findOne()

    Template.personMap.onRendered ->
        L.Icon.Default.imagePath = '/packages/bevanhunt_leaflet/images/'
        geocode.getLocation crud.findOne().address, (location) ->
            latlng = location.results[0].geometry.location
            map = L.map 'personMap'
            map.setView latlng, 8
            tile = L.tileLayer.provider 'OpenStreetMap.DE'
            tile.addTo map
            marker = L.marker latlng
            marker.addTo map

    Template.globalMap.onRendered ->
        L.Icon.Default.imagePath = '/packages/bevanhunt_leaflet/images/'
        map = L.map 'globalMap'
        map.setView [0.5, 101.44], 8
        tile = L.tileLayer.provider 'OpenStreetMap.DE'
        tile.addTo map

        for i in crud.find().fetch()
            createMarker = (i) ->
                geocode.getLocation i.address, (location) ->
                  marker = L.marker location.results[0].geometry.location
                  marker.addTo map
                  marker.bindPopup i.name
            createMarker i

if Meteor.isClient

	Template.home.onRendered ->
		$('.target').pushpin
			top: 0, bottom: 1000, offset: 0
		$('.pushpin-demo-nav').each ->
			$this = $(this)
			$target = $('#' + $(this).attr('data-target'))
			$this.pushpin
				top: $target.offset().top
				bottom: $target.offset().top + $target.outerHeight() - $this.height()

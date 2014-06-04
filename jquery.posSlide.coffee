$ = jQuery

$.fn.posSlide = (position = 'top', options) ->

    self = this

    # Default settings
    settings = $.extend
        closedPosition:     false
        openPosition:       false
        speed:              'fast'
        step:               false
    , options

    posSlideAnimationStart = () ->
        if self.is('.open')
            # Trigger before close event
            self.trigger 'posSlideBeforeClose',
                closedPosition: settings.closedPosition
                openPosition:   settings.openPosition
                speed:          settings.speed

        else
            # Trigger before open event
            self.trigger 'posSlideBeforeOpen',
                closedPosition: settings.closedPosition
                openPosition:   settings.openPosition
                speed:          settings.speed

    posSlideAnimationComplete = () ->
        if self.is('.open')
            # Trigger after close event
            self.trigger 'posSlideAfterClose',
                closedPosition: settings.closedPosition
                openPosition:   settings.openPosition
                speed:          settings.speed

            # Toggle open class
            self.removeClass 'open'
        else
            # Trigger after open event
            self.trigger 'posSlideAfterOpen',
                closedPosition: settings.closedPosition
                openPosition:   settings.openPosition
                speed:          settings.speed

            # Toggle open class
            self.addClass 'open'

    # Animation options
    animationOptions = 
        duration:   settings.speed
        step:       settings.step
        start:      posSlideAnimationStart
        complete:   posSlideAnimationComplete

    css = []

    # Function to set opened and closed positions depending on orientation
    setPositions = (orientation) =>
        switch orientation
            when 'top', 'bottom'
                if !settings.closePosition
                    settings.closedPosition = 0 - parseInt(self.outerHeight())
                if !settings.openPosition
                    settings.openPosition = 0

            when 'left', 'right'
                if !settings.closePosition
                    settings.closedPosition = 0 - parseInt(self.outerWidth())
                if !settings.openPosition
                    settings.openPosition = 0

    # Open
    open = (position) ->
        css[position] = settings.openPosition
        # Run animation
        console.log animationOptions
        self.animate css, animationOptions

    # Close
    close = (position) ->
        css[position] = settings.closedPosition
        # Run animation
        self.animate css, animationOptions

    # Set positions
    setPositions position

    if self.is('.open')
        # Slide closed
        close position
    else
        # Slide open
        open position
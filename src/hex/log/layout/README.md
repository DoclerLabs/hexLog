# Layouts

More often than not, users wish to customize not only the output destination but also the output format. This is accomplished by associating a Layout with a LogTarget. The Layout is responsible for formatting the LogEvent to the user's wishes, whereas a log target takes care of sending the formatted output to its destination.


## Layout Implementations

### AbstractLayout

Every layout should extend this class which currently provides `haxe.PosInfos` formatting.
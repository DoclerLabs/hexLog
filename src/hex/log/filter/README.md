# Filters

## Filter

In addition to automatic LogLevel filtering hexLog provides Filters that can be applied:
- before control is passed to any LoggerConfig
- after control is passed to a LoggerConfig but before calling **any** LogTargets
- after control is passed to a LoggerConfig but before calling **a specific** LogTarget
- on each LogTarget

In a manner very similar to firewall filters, each Filter can return one of three results, `ACCEPT`, `DENY` or `NEUTRAL`.
- `ACCEPT` means that no other Filters should be called and the event should progress
- `DENY` means that no other Filters should be called and the event should immediately ignored and control should be returned to the caller
- `NEUTRAL` indicates that the event should be passed to other Filters for further checking

If there are no other Filters the event will be processed.

Although Event may be accepted by a Filter the event still might not be logged because it might be denied by the Logger config or all the LogTargets.

## IFilter implementations

### AbstractFilter

Every filter should extends *AbstractFilter* class and override all the filter functions.

### AbstractFilterable

Everything that is using filters should extend *AbstractFilterable* class which already contains all the logic for filtering as well as adding, removing and composing filters.

### ThresholdFilter

Probably the simplest filter implementation is a Threshold filter which generates a result only based on a LogLevel.